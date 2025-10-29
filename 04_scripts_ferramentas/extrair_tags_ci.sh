#!/bin/bash

# Script para extrair tags de .gitlab-ci.yml de todos os projetos
# Uso: ./extrair_tags_ci.sh [diretorio_repos]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Extrator de Tags CI/CD ===${NC}\n"

# Diretório padrão ou argumento
REPOS_DIR="${1:-./repos}"

if [ ! -d "$REPOS_DIR" ]; then
    echo -e "${RED}Erro: Diretório $REPOS_DIR não encontrado${NC}"
    echo "Uso: ./extrair_tags_ci.sh [diretorio_repos]"
    exit 1
fi

# Arquivo de saída
OUTPUT_FILE="../05_dados_migracao/tags_encontradas.md"

# Criar cabeçalho
cat > "$OUTPUT_FILE" << 'HEADER'
# Tags CI/CD Encontradas - Grupo SEMAD

**Data:** $(date +%d/%m/%Y)
**Responsável:** Mateus Sturm

---

## Resumo

HEADER

# Contar projetos
TOTAL_PROJETOS=$(find "$REPOS_DIR" -name ".gitlab-ci.yml" | wc -l)
echo "- **Total de projetos com CI:** $TOTAL_PROJETOS" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Array para tags únicas
declare -A UNIQUE_TAGS

# Processar cada projeto
find "$REPOS_DIR" -name ".gitlab-ci.yml" | while read -r ci_file; do
    PROJECT_DIR=$(dirname "$ci_file")
    PROJECT_NAME=$(basename "$PROJECT_DIR")
    
    echo -e "${YELLOW}Analisando: $PROJECT_NAME${NC}"
    
    # Adicionar ao relatório
    echo "## Projeto: $PROJECT_NAME" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Extrair tags
    TAGS=$(grep -A 2 "tags:" "$ci_file" | grep -E "^\s*-\s+" | sed 's/^[[:space:]]*-[[:space:]]*//' | sort -u)
    
    if [ -n "$TAGS" ]; then
        echo "**Tags encontradas:**" >> "$OUTPUT_FILE"
        echo '```' >> "$OUTPUT_FILE"
        echo "$TAGS" >> "$OUTPUT_FILE"
        echo '```' >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        
        # Adicionar trecho do CI
        echo "**Trecho do .gitlab-ci.yml:**" >> "$OUTPUT_FILE"
        echo '```yaml' >> "$OUTPUT_FILE"
        grep -A 5 "tags:" "$ci_file" | head -n 6 >> "$OUTPUT_FILE"
        echo '```' >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        
        # Guardar tags únicas
        while IFS= read -r tag; do
            UNIQUE_TAGS["$tag"]="${UNIQUE_TAGS[$tag]} $PROJECT_NAME"
        done <<< "$TAGS"
    else
        echo "**Nenhuma tag encontrada**" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
    
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

# Adicionar índice de tags únicas
echo "" >> "$OUTPUT_FILE"
echo "## Índice de Tags Únicas" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for tag in "${!UNIQUE_TAGS[@]}"; do
    echo "### Tag: \`$tag\`" >> "$OUTPUT_FILE"
    echo "**Projetos:**${UNIQUE_TAGS[$tag]}" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo -e "${GREEN}✓ Relatório gerado: $OUTPUT_FILE${NC}"
