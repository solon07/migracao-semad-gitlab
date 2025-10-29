# Troubleshooting - Migração SEMAD

## Problemas Comuns e Soluções

### 1. Migração Falhou ou "Partially Completed"

**Sintomas:**
- Status "Failed" ou "Partially completed"
- Alguns projetos não migraram

**Soluções:**
1. Clicar em "Show errors" para ver detalhes
2. Verificar se PAT tem scope correto (`api`)
3. Verificar conectividade de rede
4. Tentar novamente: clicar em "Retry" ou refazer importação

**Erros comuns:**
- `Rate limiting`: Aguardar 5-10min e tentar novamente
- `Network timeout`: Verificar conexão, tentar novamente
- `Permission denied`: Verificar role (deve ser Owner)

---

### 2. Variável Masked Não Aceita o Valor

**Sintomas:**
- Erro ao salvar variável com "Masked" marcado
- "Value does not meet requirements for masking"

**Causa:**
Valor não atende requisitos (mín 8 caracteres, sem espaços)

**Soluções:**
1. Desmarcar "Masked" temporariamente
2. OU ajustar valor para atender requisitos
3. Documentar a mudança

---

### 3. Protected Branch Não Está Protegida

**Sintomas:**
- Branch que era protegida no CRIA não está protegida no destino
- OU branch que NÃO era protegida agora está

**Causa:**
Protected branches herdam configurações do grupo destino

**Solução:**
```
Projeto > Settings > Repository > Branch rules
Encontrar branch > Edit
Configurar proteções manualmente
```

---

### 4. PAT Expirou Durante Migração

**Sintomas:**
- Migração parou no meio
- Erro de autenticação

**Solução:**
1. Gerar novo PAT com expiração maior
2. Cancelar migração atual
3. Reiniciar do zero com novo PAT

---

### 5. Tags de Runners Não Encontradas

**Sintomas:**
- Dificuldade em encontrar todas as tags nos CIs

**Solução:**
```bash
# Usar script auxiliar
cd 04_scripts_ferramentas
./extrair_tags_ci.sh ../repos

# OU buscar manualmente
find repos/ -name ".gitlab-ci.yml" -exec grep -H "tags:" {} \;
```

---

### 6. Variável com Caracteres Especiais

**Sintomas:**
- Valor de variável tem quebras de linha ou caracteres especiais
- Dificulta copiar/colar

**Solução:**
1. Usar base64 para encode/decode:
```bash
# Encode
echo -n "valor_original" | base64

# Decode (para validar)
echo "dmFsb3Jfb3JpZ2luYWw=" | base64 -d
```
2. Documentar que variável está em base64

---

### 7. GitLab Lento ou Timeout

**Sintomas:**
- Interface muito lenta
- Requests falhando por timeout

**Soluções:**
1. Verificar status do GitLab: https://status.gitlab.com
2. Tentar em horário diferente (menos carga)
3. Usar API invés de UI (se possível)
4. Fechar outras abas do navegador

---

### 8. Não Consigo Ver Variáveis Mascaradas

**Sintomas:**
- Variável aparece como [MASKED] no CRIA
- Não consigo copiar valor

**Solução:**
1. Pedir para quem criou a variável
2. OU verificar 1Password/documentação interna
3. OU regenerar valor (se for token renovável)

---

## Comandos de Emergência

### Cancelar migração travada (via API)
```bash
# Ver status da migração
curl --header "PRIVATE-TOKEN: <seu_token>" \
  "https://gitlab.com/api/v4/bulk_imports"

# Cancelar migração
curl --request POST \
  --header "PRIVATE-TOKEN: <seu_token>" \
  "https://gitlab.com/api/v4/bulk_imports/<import_id>/cancel"
```

### Verificar logs de erro (se admin)
```bash
# No servidor GitLab (self-managed)
sudo gitlab-rails console
BulkImport.last.failures
```

---

## Contatos de Suporte

- **Supervisor:** Pedro Magalhães
- **GitLab CRIA Admin:** [verificar contato]
- **Suporte GitLab.com:** https://about.gitlab.com/support/
