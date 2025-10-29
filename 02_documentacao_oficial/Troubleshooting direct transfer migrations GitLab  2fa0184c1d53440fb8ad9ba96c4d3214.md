# Troubleshooting direct transfer migrations | GitLab Docs

Favorite: No
Created at: 29 de outubro de 2025 14:52
Status: Not started
Archive: No

# Troubleshooting direct transfer migrations

- Tier: Free, Premium, Ultimate
- Offering: GitLab.com, GitLab Self-Managed, GitLab Dedicated

In a [rails console session](https://docs.gitlab.com/administration/operations/rails%5Fconsole/#starting-a-rails-console-session), you can find the failure or error messages for the group import attempt using:

ruby

```
# Get relevant import records
import = BulkImports::Entity.where(namespace_id: Group.id).map(&:bulk_import).last

# Alternative lookup by user
import = BulkImport.where(user_id: User.find(...)).last

# Get list of import entities. Each entity represents either a group or a project
entities = import.entities

# Get a list of entity failures
entities.map(&:failures).flatten

# Alternative failure lookup by status
entities.where(status: [-1]).pluck(:destination_name, :destination_namespace, :status)
```

You can also see all migrated entities with any failures related to them using an[API endpoint](https://docs.gitlab.com/api/bulk%5Fimports/#list-all-group-or-project-migrations-entities).

## Stale imports

Migrations might stall or finish with a `timeout` status due to issues on the source or destination instance. To resolve these issues, inspect the logs from both the source and destination instances.

### Source instance

On the source instance, stale imports are often due to excessive memory usage, which might restart Sidekiq processes and interrupt export jobs. The destination instance might wait for the export files until the migration eventually times out.

To check if the [group](https://docs.gitlab.com/api/group%5Frelations%5Fexport/#export-status) or [project](https://docs.gitlab.com/api/project%5Frelations%5Fexport/#export-status) relations were successfully exported, run the following command:

shell

curl --request GET --location "[https://example.gitlab.com/api/v4/projects/:ID/export\_relations/status](https://example.gitlab.com/api/v4/projects/:ID/export\_relations/status)" \--header "PRIVATE-TOKEN: "

If a relation has a status other than `1`, the relation was not successfully exported and the issue is on the source instance.

You can also run the following command to search for interrupted export jobs. Keep in mind that Sidekiq logs might rotate after restarts, so be sure to check the rotated logs as well.

shell

```
grep `BulkImports::RelationBatchExportWorker` sidekiq.log | grep "interrupted_count"
```

If Sidekiq restarts are causing the issue:

- Configure a separate Sidekiq process for export jobs. For more information, see [Sidekiq configuration](https://docs.gitlab.com/user/project/import/#sidekiq-configuration). If the problem persists, reduce Sidekiq concurrency to limit the number of jobs processed simultaneously.
- Increase Sidekiq memory limits: If your instance has available memory, [increase the maximum RSS limit](https://docs.gitlab.com/administration/sidekiq/sidekiq%5Fmemory%5Fkiller/#configuring-the-limits) for Sidekiq processes. For example, you can increase the limit from 2 GB to 3 GB to prevent frequent restarts.
- Increase maximum interruption count: To allow more interruptions before a job fails, you can increase the maximum interruption count for[BulkImports::RelationBatchExportWorker](https://gitlab.com/gitlab-org/gitlab/-/blob/b8e11d267cdd4a00807984f98a9d8d8cfa51602e/app/workers/bulk%5Fimports/relation%5Fbatch%5Fexport%5Fworker.rb#L4):
    1. Add the following configuration to increase the limit to `20` (the default value is `3`):ruby
    
    ```
    sidekiq_options max_retries_after_interruption: 20  
    ```
    
    1. Restart Sidekiq for the changes to take effect.

You can now trigger a new migration or use the[relations export API](https://docs.gitlab.com/api/project%5Frelations%5Fexport/#schedule-new-export) to manually trigger the export. Check the [export status](https://docs.gitlab.com/api/project%5Frelations%5Fexport/#export-status) to see if relations are being exported successfully.

For example, to trigger the export of a specific project, run the following command:

shell

curl --request POST --location "[https://example.gitlab.com/api/v4/projects/:ID/export\_relations](https://example.gitlab.com/api/v4/projects/:ID/export\_relations)" \--header "PRIVATE-TOKEN: " \--form 'batched="true"'

### Destination instance

In rare cases, the destination instance might fail to migrate a group or project successfully. For more information, see [issue 498720](https://gitlab.com/gitlab-org/gitlab/-/issues/498720).

To resolve this issue, migrate the groups or projects that failed by using the [import API](https://docs.gitlab.com/api/import/). With this API, you can migrate specific groups and projects individually.

## Error: `404 Group Not Found`

If you attempt to import a group that has a path comprised of only numbers (for example, `5000`), GitLab attempts to find the group by ID instead of the path. This causes a `404 Group Not Found` error in GitLab 15.4 and earlier.

To solve this, you must change the source group path to include a non-numerical character using either:

- The GitLab UI:
    1. On the left sidebar, select Search or go to and find your group.
    2. Select Settings > General.
    3. Expand Advanced.
    4. Under Change group URL, change the group URL to include non-numeric characters.
- The [Groups API](https://docs.gitlab.com/api/groups/#update-group-attributes).

## Other `404` errors

You can receive other `404` errors when importing a group, for example:

json

```
"exception_message": "Unsuccessful response 404 from [FILTERED] Bo...",
"exception_class": "BulkImports::NetworkError",
```

This error indicates a problem transferring from the source instance. To solve this, check that you have met the[prerequisites](https://docs.gitlab.com/user/group/import/direct%5Ftransfer%5Fmigrations/#prerequisites) on the source instance.

## Mismatched group or project path names

If a source group or project path doesn’t conform to [naming rules](https://docs.gitlab.com/user/reserved%5Fnames/#rules-for-usernames-project-and-group-names-and-slugs), the path is normalized to ensure it is valid. For example, `Destination-Project-Path` is normalized to `destination-project-path`.

## Error: `command exited with error code 15 and Unable to save [FILTERED] into [FILTERED]`

You might receive the error `command exited with error code 15 and Unable to save [FILTERED] into [FILTERED]` in logs when migrating projects by using direct transfer. If you receive this error, you can safely ignore it. GitLab retries the exited command.

## Error: `Batch export [batch_number] from source instance failed`

On the destination instance, you might encounter the following error:

```
Batch export [batch_number] from source instance failed: [source instance error]
```

This error occurs when the source instance fails to export some records. The most common reasons are:

- Insufficient disk space
- Multiple interruptions of Sidekiq jobs due to insufficient memory
- Database statement timeout

To resolve this issue:

1. Identify and fix the problem on the source instance.
2. Delete the partially imported project or group from the destination instance and initiate a new import.

For more information about the relations and batches that failed to export, use the export status API endpoints for [projects](https://docs.gitlab.com/api/project%5Frelations%5Fexport/#export-status)and [groups](https://docs.gitlab.com/api/group%5Frelations%5Fexport/#export-status) on the source instance.

## Error: `duplicate key value violates unique constraint`

When importing records, you might get the following error:

```
PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint
```

This error might occur when a Sidekiq worker processing the import restarts due to high memory or CPU usage during import.

To reduce Sidekiq memory or CPU issues during import:

- Optimize [Sidekiq configuration](https://docs.gitlab.com/user/project/import/#sidekiq-configuration) for imports.
- Limit the number of concurrent jobs in the `bulk_import_concurrent_pipeline_batch_limit` [application setting](https://docs.gitlab.com/api/settings/).

## Error: `BulkImports::FileDownloadService::ServiceError Invalid content type`

When using direct transfer between GitLab instances, you might encounter the following error:

```
BulkImports::FileDownloadService::ServiceError Invalid content type
```

This error is related to how network traffic is routed between instances. If a content type other than `application/gzip` is returned, your network requests might be bypassing GitLab Workhorse.

To resolve this issue:

- Check that your Ingress is configured to route traffic through GitLab Workhorse on port `8181` rather than directly to Puma.
- Consider enabling [proxy downloads](https://docs.gitlab.com/administration/object%5Fstorage/#proxy-download) for object storage.