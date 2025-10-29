#!/bin/bash

# Script para validar estrutura após migração
# Uso: ./validar_migracao.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== Validador de Migração SEMAD ===${NC}\n"

# Estrutura esperada
EXPECTED_SUBGROUPS=("Alerta" "Consulta" "Fiscalizacao" "Gerenciamento")
EXPECTED_PROJECTS=(
    "semad-alerta-api"
    "semad-alerta-frontend"
    "semad-alerta-mobile"
    "semad-consulta-frontend"
    "semad-consulta-mobile"
    "consulta-pdf"
    "semad-fiscalizacao-frontend"
    "semad-fiscalizacao-mobile"
    "semad-gerenciamento-frontend"
    "bug-tracker-semad"
    "microservicos-semad"
    "pbl"
    "semad-admin-api"
    "tramitacao"
)

echo "Validando estrutura..."
echo ""

# TODO: Implementar validação via API do GitLab
# Requer configuração de PAT

echo -e "${YELLOW}⚠ Este script requer implementação de chamadas à API do GitLab${NC}"
echo "Por enquanto, valide manualmente:"
echo ""
echo "1. Verificar subgrupos:"
for subgroup in "${EXPECTED_SUBGROUPS[@]}"; do
    echo "   - [ ] $subgroup"
done
echo ""
echo "2. Verificar projetos (total: ${#EXPECTED_PROJECTS[@]}):"
for project in "${EXPECTED_PROJECTS[@]}"; do
    echo "   - [ ] $project"
done
echo ""
echo "3. Clonar 2-3 projetos e verificar histórico Git"
echo "4. Verificar issues e MRs preservados"
echo "5. Verificar protected branches"
