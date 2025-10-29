# Resumo Consolidado - Variáveis CI/CD SEMAD

**Data:** 29/10/2025
**Responsável:** Mateus Sturm
**Issue:** #1772

---

## 🔑 Credenciais de Registry (1Password)

### Registry 1: meioambiente.go.gov.br
- **Username:** deploy
- **Password:** [Ver 1Password: "SEMAD - Registry meioambiente.go.gov.br"]
- **Usado em:**
  - Grupo SEMAD (variável: REGISTRY_PASSWORD) ⚠️ MASKED
  - Projeto tramitacao (variável: REGISTRY_PASSWORD)
  - Projeto Microserviços SEMAD (variáveis: docker_password, REGISTRY_PASSWORD)

### Registry 2: criainovacao.com.br
- **Username:** semad
- **Password:** [Ver 1Password: "SEMAD - Registry criainovacao.com.br (Consulta-PDF)"]
- **Usado em:**
  - Projeto Consulta - PDF (variável: REGISTRY_PASSWORD)

---

## 📊 Variáveis por Escopo

### Grupo SEMAD (3 variáveis)
| Key | Masked | Env Scope | Valor |
|-----|--------|-----------|-------|
| REGISTRY_URL | ❌ | * | registry.meioambiente.go.gov.br |
| REGISTRY_USER | ❌ | * | deploy |
| REGISTRY_PASSWORD | ✅ | * | [1Password] |

### Projeto: tramitacao (3 variáveis)
| Key | Masked | Env Scope | Valor |
|-----|--------|-----------|-------|
| REGISTRY_URL | ❌ | * | registry.meioambiente.go.gov.br |
| REGISTRY_USER | ❌ | * | deploy |
| REGISTRY_PASSWORD | ❌ | * | [1Password - mesmo do grupo] |

### Projeto: Consulta - PDF (3 variáveis)
| Key | Masked | Env Scope | Valor |
|-----|--------|-----------|-------|
| REGISTRY_URL | ❌ | * | registry.criainovacao.com.br |
| REGISTRY_USER | ❌ | * | semad |
| REGISTRY_PASSWORD | ❌ | * | [1Password - diferente] |

### Projeto: Microserviços SEMAD (5 variáveis)
| Key | Masked | Env Scope | Valor |
|-----|--------|-----------|-------|
| REGISTRY_URL | ❌ | * | registry.meioambiente.go.gov.br |
| REGISTRY_USER | ❌ | * | deploy |
| REGISTRY_PASSWORD | ❌ | * | [1Password - mesmo do grupo] |
| docker_user | ❌ | * | deploy |
| docker_password | ❌ | * | [1Password - mesmo do grupo] |

---

## 📋 Checklist de Recriação (Fase 3)

### Grupo SEMAD - gitlab.com/youx-group/semad
- [ ] REGISTRY_URL = registry.meioambiente.go.gov.br
- [ ] REGISTRY_USER = deploy
- [ ] REGISTRY_PASSWORD = [1Password] - ⚠️ MARCAR COMO MASKED

### Projeto tramitacao
- [ ] REGISTRY_URL = registry.meioambiente.go.gov.br
- [ ] REGISTRY_USER = deploy
- [ ] REGISTRY_PASSWORD = [1Password - mesmo do grupo]

### Projeto Consulta - PDF
- [ ] REGISTRY_URL = registry.criainovacao.com.br
- [ ] REGISTRY_USER = semad
- [ ] REGISTRY_PASSWORD = [1Password - diferente]

### Projeto Microserviços SEMAD
- [ ] REGISTRY_URL = registry.meioambiente.go.gov.br
- [ ] REGISTRY_USER = deploy
- [ ] REGISTRY_PASSWORD = [1Password - mesmo do grupo]
- [ ] docker_user = deploy
- [ ] docker_password = [1Password - mesmo do grupo]

### Projetos SEM variáveis (11 projetos)
- PBL
- SEMAD Gerenciamento Frontend
- SEMAD Consulta Frontend
- SEMAD Consulta Mobile
- SEMAD Alerta Frontend
- Bug Tracker SEMAD
- SEMAD Fiscalização Frontend
- SEMAD Fiscalização Mobile
- SEMAD Admin API
- SEMAD Alerta Mobile
- SEMAD Alerta API

**✅ Nenhuma ação necessária para esses projetos na Fase 3**

---

## ⚠️ Observações Importantes

1. **Duplicação de senhas:** A senha `6ZT1Kx0Gg92J` está duplicada em:
   - Grupo (como variável de grupo)
   - tramitacao (como variável de projeto)
   - Microserviços SEMAD (2x: docker_password + REGISTRY_PASSWORD)
   
   **Decisão de migração:** Manter apenas no grupo. Os projetos herdam automaticamente.

2. **Consulta-PDF usa registry diferente:** Precisa de credenciais separadas.

3. **Microserviços tem variáveis duplicadas:** 
   - `docker_user` + `REGISTRY_USER` (ambos: deploy)
   - `docker_password` + `REGISTRY_PASSWORD` (ambos: mesma senha)
   
   **Decisão:** Verificar com Pedro se precisa manter duplicação ou pode consolidar.

