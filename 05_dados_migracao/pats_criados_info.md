# Personal Access Tokens - Migração SEMAD

**Data:** 29/10/2025
**Responsável:** Mateus Sturm
**Issue:** #1772

---

## ⚠️ ATENÇÃO: Tokens estão no 1Password

Os valores dos tokens NÃO estão neste arquivo por segurança.
Consultar: 1Password > Vault "YOUX Work" > Buscar "SEMAD - PAT"

---

## PAT 1: GitLab CRIA (Source)

- **Localização 1Password:** `SEMAD - PAT GitLab CRIA (Migration)`
- **Nome do token:** Migration SEMAD to gitlab.com
- **Usuário:** mateus.sturm
- **Instância:** https://gitlab.criainovacao.com.br
- **Scope:** api
- **Expiração:** 30/10/2025
- **Finalidade:** Autenticar acesso à instância origem durante migração

---

## PAT 2: gitlab.com (Destination)

- **Localização 1Password:** `SEMAD - PAT gitlab.com (Migration)`
- **Nome do token:** Migration SEMAD from CRIA
- **Usuário:** mateus.sturm (ou seu user no gitlab.com)
- **Instância:** https://gitlab.com
- **Scope:** api
- **Expiração:** 30/10/2025
- **Finalidade:** Autenticar acesso à instância destino durante migração

---

## 🔒 Segurança

- ✅ Tokens salvos no 1Password
- ✅ Tokens NÃO commitados no Git
- ✅ Tokens com expiração curta (1 dia)
- ✅ Tokens serão revogados após migração concluída

---

## 🗑️ Lembrete Pós-Migração

Após concluir a migração (Fase 5), REVOGAR ambos os tokens:
- [ ] Revogar PAT CRIA: https://gitlab.criainovacao.com.br/-/user_settings/personal_access_tokens
- [ ] Revogar PAT gitlab.com: https://gitlab.com/-/user_settings/personal_access_tokens

