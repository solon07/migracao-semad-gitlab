# Items migrated when using direct transfer | GitLab Docs

Favorite: No
Created at: 29 de outubro de 2025 14:52
Status: Not started
Archive: No

# Items migrated when using direct transfer

- Tier: Free, Premium, Ultimate
- Offering: GitLab.com, GitLab Self-Managed, GitLab Dedicated

Many items are migrated when using the direct transfer method, and some are excluded.

## Migrated group items

The group items that are migrated depend on the version of GitLab you use on the destination. To determine if a specific group item is migrated:

1. Check the [groups/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/bulk%5Fimports/groups/stage.rb)file for all editions and the[groups/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/master/ee/lib/ee/bulk%5Fimports/groups/stage.rb) file for Enterprise Edition for your version on the destination. For example, for version 15.9:
    - [https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/bulk%5Fimports/groups/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/bulk%5Fimports/groups/stage.rb) (all editions).
    - [https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/ee/lib/ee/bulk%5Fimports/groups/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/ee/lib/ee/bulk%5Fimports/groups/stage.rb) (Enterprise Edition).
1. Check the[group/import_export.yml](https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/import%5Fexport/group/import%5Fexport.yml)file for groups for your version on the destination. For example, for version 15.9:[https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/gitlab/import%5Fexport/group/import%5Fexport.yml](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/gitlab/import%5Fexport/group/import%5Fexport.yml).

Any other group items are not migrated.

Group items that are migrated to the destination GitLab instance include:

- Badges
- Boards
- Board lists
- Epics
- Epic boards
- Epic board lists
- Group labelsGroup labels cannot retain any associated label priorities during import. You must prioritize these labels again manually after you migrate the relevant project to the destination instance.
- Group milestones
- Iterations
- Iteration cadences
- [Members](https://docs.gitlab.com/user/group/import/direct%5Ftransfer%5Fmigrations/#user-membership-mapping)
- Namespace settings
- Release milestones
- Subgroups
- Uploads
- Wikis

### Excluded items

Some group items are excluded from migration because they:

- Might contain sensitive information:
    - CI/CD variables
    - Deploy tokens
    - Webhooks
- Are not supported:
    - Custom fields
    - Iteration cadence settings
    - Pending member invitations
    - Push rules

In addition, users and any [personal access tokens](https://docs.gitlab.com/user/profile/personal%5Faccess%5Ftokens/) they create are excluded from migration.

## Migrated project items

History

- [Enabled on GitLab.com](https://gitlab.com/gitlab-org/gitlab/-/issues/339941) in GitLab 15.6.
- `bulk_import_projects` feature flag [removed](https://gitlab.com/gitlab-org/gitlab/-/issues/339941) in GitLab 15.10.
- Project migrations through the API [added](https://gitlab.com/gitlab-org/gitlab/-/issues/390515) in GitLab 15.11.
- [Generally available](https://gitlab.com/gitlab-org/gitlab/-/issues/461326) in GitLab 18.3.

If you choose to migrate projects when you [select groups to migrate](https://docs.gitlab.com/user/group/import/direct%5Ftransfer%5Fmigrations/#select-the-groups-and-projects-to-import), project items are migrated with the projects.

The project items that are migrated depends on the version of GitLab you use on the destination. To determine if a specific project item is migrated:

1. Check the [projects/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/bulk%5Fimports/projects/stage.rb)file for all editions and the[projects/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/master/ee/lib/ee/bulk%5Fimports/projects/stage.rb)file for Enterprise Edition for your version on the destination. For example, for version 15.9:
    - [https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/bulk%5Fimports/projects/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/bulk%5Fimports/projects/stage.rb) (all editions).
    - [https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/ee/lib/ee/bulk%5Fimports/projects/stage.rb](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/ee/lib/ee/bulk%5Fimports/projects/stage.rb) (Enterprise Edition).
1. Check the[project/import_export.yml](https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/import%5Fexport/project/import%5Fexport.yml)file for projects for your version on the destination. For example, for version 15.9:[https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/gitlab/import%5Fexport/project/import%5Fexport.yml](https://gitlab.com/gitlab-org/gitlab/-/blob/15-9-stable-ee/lib/gitlab/import%5Fexport/project/import%5Fexport.yml).

Any other project items are not migrated.

If you choose not to migrate projects along with groups or if you want to retry a project migration, you can initiate project-only migrations using the [API](https://docs.gitlab.com/api/bulk%5Fimports/).

Project items that are migrated to the destination GitLab instance include:

- Auto DevOps
- Badges
- Branches (including protected branches)Imported branches respect the [default branch protection settings](https://docs.gitlab.com/user/project/repository/branches/protected/) of the destination group. These settings might cause an unprotected branch to be imported as protected.
- CI pipelines
- Commit comments
- Designs
- External merge requests
- Issues
- Issue boards
- Labels
- LFS objects
- [Members](https://docs.gitlab.com/user/group/import/direct%5Ftransfer%5Fmigrations/#user-membership-mapping)
- Merge requests
- Milestones
- Pipeline history
- Pipeline schedules
- Projects
- Project features
- Push rules
- Releases
- Release evidences
- Repositories
- Settings
- Snippets
- Uploads
- Vulnerability reports[Introduced](https://gitlab.com/gitlab-org/gitlab/-/issues/501466) in GitLab 17.7. Vulnerability reports are migrated without their status. For more information, see [issue 512859](https://gitlab.com/gitlab-org/gitlab/-/issues/512859). For the `ActiveRecord::RecordNotUnique` error when migrating vulnerability reports, see [issue 509904](https://gitlab.com/gitlab-org/gitlab/-/issues/509904).
- Wikis

### Issue-related items

Issue-related project items that are migrated to the destination GitLab instance include:

- Issue comments
- Issue iterations
- Issue resource iteration events
- Issue resource milestone events
- Issue resource state events
- Merge request URL references
- Time tracking

### Merge request-related items

Merge request-related project items that are migrated to the destination GitLab instance include:

- Issue URL references
- Merge request approvers
- Merge request comments
- Merge request resource milestone events
- Merge request resource state events
- Merge request reviewers
- Multiple merge request assignees
- Time tracking

### Setting-related items

Setting-related project items that are migrated to the destination GitLab instance include:

- Avatar
- Container expiration policy
- Project properties
- Service Desk

### Excluded items

Some project items are excluded from migration because they:

- Might contain sensitive information:
    - CI/CD job logs
    - CI/CD variables
    - Container registry images
    - Deploy keys
    - Deploy tokens
    - Encrypted tokens
    - Job artifacts
    - Pipeline schedule variables
    - Pipeline triggers
    - Webhooks
- Are not supported:
    - Agents
    - [Child CI/CD pipelines](https://gitlab.com/gitlab-org/gitlab/-/issues/571159)
    - Container registry
    - Custom fields
    - Environments
    - Feature flags
    - Infrastructure registry
    - Instance administrators in branch protection rules when migrating from GitLab Self-Managed to GitLab.com or GitLab Dedicated
    - Linked issues
    - Merge request approval rules
    - Merge request dependencies
    - Package registry
    - Pages domains
    - Pending member invitations
    - Remote mirrors
    - Wiki commentsApproval rules related to project settings are imported.
- Do not contain recoverable data:
    - Merge requests with no diff or source information (for more information, see [issue 537943](https://gitlab.com/gitlab-org/gitlab/-/issues/537943))

In addition, users and any [personal access tokens](https://docs.gitlab.com/user/profile/personal%5Faccess%5Ftokens/) they create are excluded from migration.