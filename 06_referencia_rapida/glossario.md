# Glossário GitLab

## Termos da Migração

**Direct Transfer**
Método oficial recomendado pelo GitLab para migrar grupos e projetos entre instâncias diferentes. Copia toda a estrutura incluindo código, issues, MRs, etc.

**PAT (Personal Access Token)**
Token de autenticação usado para acessar a API do GitLab. Requer scope `api` para migração.

**Protected Branch**
Branch com regras de proteção que impedem push direto. Geralmente usada para main/master/production.

**Masked Variable**
Variável CI/CD cujo valor não aparece nos logs de pipeline. Requer valor mínimo de 8 caracteres.

**Protected Variable**
Variável CI/CD disponível apenas em branches ou tags protegidas.

**Runner Tag**
Identificador usado no `.gitlab-ci.yml` para selecionar qual runner executará o job.

**Deploy Token**
Token específico para permitir deployment sem usar credenciais de usuário.

**Webhook**
URL callback chamada automaticamente quando eventos ocorrem no GitLab.

**LFS (Large File Storage)**
Sistema do Git para armazenar arquivos grandes fora do repositório principal.

**Pipeline Schedule**
Agendamento de pipeline para executar em horários específicos.

---

## Comandos Úteis

### Git
```bash
# Clonar com LFS
git lfs clone <url>

# Ver histórico
git log --oneline --graph --all

# Verificar branches remotas
git branch -r

# Verificar tags
git tag -l
```

### GitLab CLI (se instalado)
```bash
# Listar projetos
glab repo list

# Ver issues
glab issue list

# Ver MRs
glab mr list
```

### API GitLab
```bash
# Listar variáveis do grupo (curl)
curl --header "PRIVATE-TOKEN: <seu_token>" \
  "https://gitlab.com/api/v4/groups/<group_id>/variables"

# Listar projetos do grupo
curl --header "PRIVATE-TOKEN: <seu_token>" \
  "https://gitlab.com/api/v4/groups/<group_id>/projects"
```
