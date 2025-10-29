#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}=== Extrator de Variáveis CI/CD dos Projetos SEMAD ===${NC}\n"

PROJETOS_FILE="05_dados_migracao/lista_projetos_semad.txt"
OUTPUT_FILE="05_dados_migracao/variaveis_todos_projetos_raw.txt"

if [ ! -f "$PROJETOS_FILE" ]; then
    echo -e "${RED}Erro: Arquivo $PROJETOS_FILE não encontrado${NC}"
    echo "Execute primeiro: glab api --hostname gitlab.criainovacao.com.br \"/groups/110/projects?per_page=100&include_subgroups=true\" | jq -r '.[] | [.id, .name, .path_with_namespace] | @tsv' > $PROJETOS_FILE"
    exit 1
fi

TOTAL_PROJETOS=$(wc -l < "$PROJETOS_FILE")
echo -e "${BLUE}Total de projetos a processar: $TOTAL_PROJETOS${NC}\n"

> "$OUTPUT_FILE"

CONTADOR=0

while IFS=$'\t' read -r project_id project_name project_path; do
    CONTADOR=$((CONTADOR + 1))
    echo -e "${YELLOW}[$CONTADOR/$TOTAL_PROJETOS] Extraindo variáveis de: $project_name${NC}"
    
    echo "=== PROJETO: $project_name ===" >> "$OUTPUT_FILE"
    echo "Path: $project_path" >> "$OUTPUT_FILE"
    echo "ID: $project_id" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    VARS=$(glab api --hostname gitlab.criainovacao.com.br "/projects/$project_id/variables" 2>/dev/null)
    
    if [ -n "$VARS" ] && [ "$VARS" != "[]" ]; then
        echo "$VARS" | jq -r '.[] | [.key, .value, .variable_type, .protected, .masked, .environment_scope] | @tsv' >> "$OUTPUT_FILE"
        TOTAL_VARS=$(echo "$VARS" | jq '. | length')
        echo -e "${GREEN}   ✓ $TOTAL_VARS variável(is) encontrada(s)${NC}"
    else
        echo "Nenhuma variável encontrada" >> "$OUTPUT_FILE"
        echo -e "${BLUE}   ℹ Nenhuma variável encontrada${NC}"
    fi
    
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    sleep 0.5  # Rate limiting gentil
done < "$PROJETOS_FILE"

echo ""
echo -e "${GREEN}✓ Extração concluída!${NC}"
echo -e "${GREEN}  Arquivo gerado: $OUTPUT_FILE${NC}"
echo ""
echo "Resumo:"
echo "  - Projetos processados: $TOTAL_PROJETOS"
echo "  - Linhas totais geradas: $(wc -l < "$OUTPUT_FILE")"
echo "  - Projetos com variáveis: $(grep -c "=== PROJETO:" "$OUTPUT_FILE")"
