# Checklist Completo - Migração SEMAD

## Data início: ___/___/2025
## Data fim: ___/___/2025
## Responsável: Mateus Sturm

---

## ☑️ FASE 1: Preparação

- [X] 1.1 Documentar variáveis CI/CD do grupo SEMAD (CRIA)
- [X] 1.2 Documentar variáveis de todos os 14 projetos
- [X] 1.3 Salvar variáveis sensíveis no 1Password
- [X] 1.4 Gerar PAT no GitLab CRIA (scope: api, exp: +1 dia)
- [X] 1.5 Gerar PAT no gitlab.com (scope: api, exp: +1 dia)
- [X] 1.6 Salvar PATs no 1Password
- [X] 1.7 Deletar grupo SEMAD do gitlab.com/youx-group
- [X] 1.8 Deletar grupo SEMAD_1 do gitlab.com/youx-group
- [X] 1.9 Confirmar deleção bem-sucedida

**Pausa 10min ☕**

---

## ☑️ FASE 2: Migração Direct Transfer

- [X] 2.1 Acessar gitlab.com/youx-group
- [X] 2.2 Iniciar "Import group"
- [X] 2.3 Conectar instância CRIA (URL + PAT)
- [X] 2.4 Selecionar grupo SEMAD
- [X] 2.5 Marcar "Import with projects"
- [X] 2.6 Marcar "Import user memberships" (se aplicável)
- [X] 2.7 Verificar namespace: /youx-group/semad
- [X] 2.8 Iniciar importação
- [X] 2.9 Monitorar progresso (não fechar aba!)
- [X] 2.10 Aguardar status "Complete" ou "Partially completed"
- [X] 2.11 Clicar em "View details" se houver erros
- [X] 2.12 Documentar erros (se houver) em log_migracao.md

**Pausa 15min ☕**

---

## ☑️ FASE 3: Validação Estrutural

- [X] 3.1 Verificar 4 subgrupos criados
- [X] 3.2 Verificar 14 projetos criados
- [X] 3.3 Clonar 2-3 projetos e verificar histórico Git
- [X] 3.4 Verificar issues preservadas (amostragem)
- [X] 3.5 Verificar MRs preservados (amostragem)
- [X] 3.6 Verificar labels e milestones
- [X] 3.7 Verificar protected branches configuradas

**Pausa 10min ☕**

---

## ☑️ FASE 4: Recriar Variáveis CI/CD

### Grupo SEMAD
- [X] 4.1 Acessar gitlab.com/youx-group/semad/settings/ci_cd
- [X] 4.2 Recriar variável 1: REGISTRY_URL
- [X] 4.3 Recriar variável 2: REGISTRY_USER
- [X] 4.4 Recriar variável 3: REGISTRY_PASSWORD (🔒 MASKED)
- [X] 4.5 Validar: todas variáveis do grupo recriadas

### Projetos Individuais

#### Alerta
- [X] 4.6 SEMAD Alerta API - ✅ Sem variáveis (herda do grupo)
- [X] 4.7 SEMAD Alerta Frontend - ✅ Sem variáveis (herda do grupo)
- [X] 4.8 SEMAD Alerta Mobile - ✅ Sem variáveis (herda do grupo)

#### Consulta
- [X] 4.9 SEMAD Consulta Frontend - ✅ Sem variáveis (herda do grupo)
- [X] 4.10 SEMAD Consulta Mobile - ✅ Sem variáveis (herda do grupo)
- [X] 4.11 Consulta - PDF - ✅ 3 variáveis recriadas (registry diferente)

#### Fiscalização
- [X] 4.12 SEMAD Fiscalização Frontend - ✅ Sem variáveis (herda do grupo)
- [X] 4.13 SEMAD Fiscalização Mobile - ✅ Sem variáveis (herda do grupo)

#### Gerenciamento
- [X] 4.14 SEMAD Gerenciamento Frontend - ✅ Sem variáveis (herda do grupo)

#### Raiz
- [X] 4.15 Bug Tracker SEMAD - ✅ Sem variáveis (herda do grupo)
- [X] 4.16 Microserviços SEMAD - ✅ 5 variáveis recriadas (com duplicação)
- [X] 4.17 PBL - ✅ Sem variáveis (herda do grupo)
- [X] 4.18 SEMAD Admin API - ✅ Sem variáveis (herda do grupo)
- [X] 4.19 tramitacao - ✅ 3 variáveis recriadas

**Pausa 10min ☕**

---

## ☑️ FASE 5: Documentar Tags CI/CD

- [X] 5.1 Analisar .gitlab-ci.yml de cada projeto
- [X] 5.2 Documentar tags em tags_raw.txt
- [X] 5.3 Gerar relatório consolidado
- [X] 5.4 Anexar relatório na issue 

---

## ☑️ FASE 6: Validação Final

- [ ] 6.1 Conferir checklist completo
- [ ] 6.2 Testar clone de 3 projetos aleatórios
- [ ] 6.3 Validar branches protegidas
- [ ] 6.4 Validar variáveis (verificar 3 projetos)
- [ ] 6.5 Conferir documentação de tags completa
- [ ] 6.6 Gerar resumo executivo
- [ ] 6.7 Atualizar issue #1772 com progresso
- [ ] 6.8 Comunicar Pedro sobre conclusão

---

## ☑️ PÓS-MIGRAÇÃO (Fora do escopo desta issue)

- [ ] Registrar runners no gitlab.com/youx-group
- [ ] Atualizar tags nos .gitlab-ci.yml (se necessário)
- [ ] Testar pipelines
- [ ] Comunicar time dev que migração concluída

---

## 📊 Métricas

- **Início:** ___:___ (___/___/2025)
- **Fim:** ___:___ (___/___/2025)
- **Duração total:** ___ horas
- **Pausas:** ___ minutos
- **Erros encontrados:** ___
- **Retries necessários:** ___

---

## 📝 Notas e Observações

[Adicionar aqui qualquer observação importante durante a migração]
