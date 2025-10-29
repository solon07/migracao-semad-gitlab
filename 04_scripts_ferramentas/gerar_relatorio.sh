#!/bin/bash

# Script para gerar relatório de progresso da migração
# Uso: ./gerar_relatorio.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== Gerador de Relatório de Progresso ===${NC}\n"

CHECKLIST_FILE="../03_templates_checklists/checklist_migracao.md"
OUTPUT_FILE="../05_dados_migracao/relatorio_progresso_$(date +%Y%m%d_%H%M%S).md"

# Contar tarefas totais e completas
TOTAL=$(grep -c "\[ \]" "$CHECKLIST_FILE" || echo 0)
COMPLETAS=$(grep -c "\[x\]" "$CHECKLIST_FILE" || echo 0)

# Calcular percentual
if [ "$TOTAL" -gt 0 ]; then
    PERCENTUAL=$(echo "scale=2; ($COMPLETAS / $TOTAL) * 100" | bc)
else
    PERCENTUAL=0
fi

# Gerar relatório
cat > "$OUTPUT_FILE" << REPORT
# Relatório de Progresso - Migração SEMAD

**Data:** $(date '+%d/%m/%Y %H:%M:%S')
**Responsável:** Mateus Sturm

---

## Status Geral

- **Progresso:** $COMPLETAS / $TOTAL tarefas (${PERCENTUAL}%)
- **Fase atual:** [Identificar manualmente]

---

## Tarefas Pendentes

REPORT

# Adicionar tarefas pendentes
grep "\[ \]" "$CHECKLIST_FILE" >> "$OUTPUT_FILE" || echo "Nenhuma tarefa pendente" >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "## Tarefas Concluídas" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Adicionar tarefas concluídas
grep "\[x\]" "$CHECKLIST_FILE" >> "$OUTPUT_FILE" || echo "Nenhuma tarefa concluída ainda" >> "$OUTPUT_FILE"

echo -e "${GREEN}✓ Relatório gerado: $OUTPUT_FILE${NC}"
