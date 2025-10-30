# Relatório Consolidado - Tags CI/CD Runners

**Data:** 30/10/2025
**Responsável:** Mateus Sturm
**Issue:** #1772
**Fase:** 5/5

---

## 📊 Resumo Executivo

- **Total de projetos analisados:** 14
- **Projetos com CI funcional:** 8
  - Com tags de runners: 5
  - Sem tags (runners padrão): 3
- **Projetos sem CI:** 6
- **Tags únicas identificadas:** 7

---

## 🏷️ Tags Identificadas

### `deploy-ina-homolog`

**Usado em:** 5 projeto(s)

**Projetos:**
- tramitacao
- Microservios SEMAD
- SEMAD Alerta Frontend
- SEMAD Fiscalizao Frontend
- SEMAD Gerenciamento Frontend

**Tipo:** Runner de Deploy

---

### `deploy-prod-microsservices-semad`

**Usado em:** 2 projeto(s)

**Projetos:**

**Tipo:** Runner de Deploy

---

### `ina-proxmox`

**Usado em:** 5 projeto(s)

**Projetos:**

**Tipo:** Runner de Build (Kaniko)

---

### `semad-fiscalizacao-frontend-prod`

**Usado em:** 1 projeto(s)

**Projetos:**

**Tipo:** Runner Específico

---

### `semad-gerenciamento-front-prod`

**Usado em:** 1 projeto(s)

**Projetos:**

**Tipo:** Runner Específico

---

### `semad-microsservicos-prod`

**Usado em:** 1 projeto(s)

**Projetos:**

**Tipo:** Runner Específico

---

### `semad-tramitacao-prod`

**Usado em:** 1 projeto(s)

**Projetos:**

**Tipo:** Runner Específico

---


## 📋 Detalhamento por Projeto

### ✅ Projetos com CI e Tags (5)

#### 1. tramitacao
**Tags:**
- `ina-proxmox` (build)
- `deploy-ina-homolog` (deploy homolog)
- `deploy-prod-microsservices-semad` (deploy prod)
- `semad-tramitacao-prod` (deploy prod específico)

#### 2. Microserviços SEMAD
**Tags:**
- `ina-proxmox` (build)
- `deploy-ina-homolog` (deploy homolog)
- `deploy-prod-microsservices-semad` (deploy prod)
- `semad-microsservicos-prod` (deploy prod específico)

#### 3. SEMAD Alerta Frontend
**Tags:**
- `ina-proxmox` (build)
- `deploy-ina-homolog` (deploy homolog)

#### 4. SEMAD Fiscalização Frontend
**Tags:**
- `ina-proxmox` (build)
- `deploy-ina-homolog` (deploy homolog)
- `semad-fiscalizacao-frontend-prod` (deploy prod)

#### 5. SEMAD Gerenciamento Frontend
**Tags:**
- `ina-proxmox` (build)
- `deploy-ina-homolog` (deploy homolog)
- `semad-gerenciamento-front-prod` (deploy prod)

---

### ℹ️ Projetos com CI mas Sem Tags (3)

Estes projetos possuem `.gitlab-ci.yml` mas não especificam tags, usando runners padrão:

- **SEMAD Admin API** - CI funcional sem tags específicas
- **SEMAD Alerta API** - CI funcional sem tags específicas
- **Consulta - PDF** - CI funcional sem tags específicas

---

### ❌ Projetos Sem CI Válido (6)

Estes projetos não possuem `.gitlab-ci.yml` válido na branch HEAD:

- PBL
- Bug Tracker SEMAD
- SEMAD Alerta Mobile
- SEMAD Consulta Frontend
- SEMAD Consulta Mobile
- SEMAD Fiscalização Mobile

---

## 🎯 Padrões Identificados

### Build (Homologação)
- **Tag:** `ina-proxmox`
- **Uso:** Build de imagens Docker com Kaniko
- **Projetos:** 5

### Deploy (Homologação)
- **Tag:** `deploy-ina-homolog`
- **Uso:** Deploy em ambiente de homologação
- **Projetos:** 5

### Deploy (Produção - Genérico)
- **Tag:** `deploy-prod-microsservices-semad`
- **Uso:** Deploy em produção (tramitacao e microserviços)
- **Projetos:** 2

### Deploy (Produção - Específico)
Tags específicas por projeto:
- `semad-tramitacao-prod`
- `semad-microsservicos-prod`
- `semad-fiscalizacao-frontend-prod`
- `semad-gerenciamento-front-prod`

---

## ✅ Ações Necessárias

### Próximos Passos (Pós-Migração)

- [ ] **Registrar runners no gitlab.com/youx-group** com as tags identificadas
- [ ] **Configurar runner Kaniko** com tag `ina-proxmox`
- [ ] **Configurar runner de deploy homolog** com tag `deploy-ina-homolog`
- [ ] **Configurar runners de produção** com tags específicas por projeto
- [ ] **Testar pipelines** após configuração dos runners
- [ ] **Atualizar .gitlab-ci.yml** se necessário (mudança de registry, etc.)

### Observações Importantes

1. **Tags mais usadas:** `ina-proxmox` e `deploy-ina-homolog` são críticas (5 projetos cada)
2. **Prioridade:** Configurar primeiro os runners de build e deploy homolog
3. **Projetos sem CI:** Verificar com time dev se é esperado ou se faltam arquivos
4. **Runners de produção:** Tags específicas sugerem isolamento por projeto

---

## 📎 Arquivos Relacionados

- `05_dados_migracao/tags_raw.txt` - Tags extraídas por projeto
- `05_dados_migracao/projetos_sem_ci.txt` - Projetos sem CI
- `05_dados_migracao/lista_projetos_gitlab_com.txt` - Lista completa de projetos
- `temp_ci_analysis/ci_files/` - Arquivos .gitlab-ci.yml baixados

---

**Relatório gerado automaticamente em:** 30/10/2025
**Ferramenta:** Scripts de análise customizados
