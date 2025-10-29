# Comandos Úteis - Migração SEMAD

## Git - Validação
```bash
# Clonar projeto e verificar
git clone <url>
cd <projeto>

# Ver último commit
git log -1

# Ver todas as branches
git branch -a

# Ver tags
git tag

# Verificar histórico completo
git log --oneline --graph --all --decorate

# Contar commits
git rev-list --count HEAD
```

## GitLab - URLs Importantes
```bash
# CRIA (origem)
https://gitlab.criainovacao.com.br/semad

# gitlab.com (destino)
https://gitlab.com/youx-group/semad

# Settings CI/CD de um projeto
https://gitlab.com/youx-group/semad/<subgrupo>/<projeto>/-/settings/ci_cd

# Protected branches
https://gitlab.com/youx-group/semad/<subgrupo>/<projeto>/-/settings/repository#js-protected-branches-settings
```

## Terminal - Produtividade
```bash
# Encontrar todos .gitlab-ci.yml
find . -name ".gitlab-ci.yml"

# Buscar palavra em arquivos
grep -r "tags:" . --include="*.yml"

# Contar linhas de um arquivo
wc -l arquivo.md

# Ver estrutura de diretórios
tree -L 2

# Buscar em histórico de comandos
history | grep git
```

## VS Code - Atalhos
```
Ctrl+Shift+P - Command Palette
Ctrl+P - Quick Open (buscar arquivos)
Ctrl+` - Toggle Terminal
Ctrl+B - Toggle Sidebar
Ctrl+Shift+F - Buscar em todos arquivos
Ctrl+Shift+H - Replace em todos arquivos
Ctrl+/ - Toggle line comment
Ctrl+K Ctrl+C - Add line comment
Ctrl+K Ctrl+U - Remove line comment
F2 - Rename symbol
Ctrl+Space - Trigger suggestions
```
