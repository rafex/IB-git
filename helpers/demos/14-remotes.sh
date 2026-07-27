#!/usr/bin/env bash
# demo-remotes.sh — Diapositiva 14: Los cuatro movimientos
# Crea bare repo + dos clones, simula push/pull entre Ana y Luis.

set -e

DIR="workspace-slides/14-remotes"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "14" "Los cuatro movimientos que sí debes distinguir"

concepto "clone, fetch, pull, push mueven información entre lugares distintos." \
  "fetch trae referencias sin tocar archivos. pull integra. push publica."

pausa

# ── Crear semilla ──
cmd "# 1. Creamos un repositorio semilla con un commit inicial"
mkdir semilla && cd semilla
git init | output
git branch -m main
git config pull.rebase false
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
git add agenda.txt
git commit -m "agrega agenda inicial" | output
cd ..

# ── Bare remote ──
cmd "# 2. Creamos un repositorio bare (simula GitHub/GitLab)"
git clone --bare semilla origin 2>/dev/null

echo -e "  ${DIM}origin/ es un bare repo: no tiene working tree, solo historial.${RESET}"

# ── Clones ──
cmd "# 3. Ana clona desde origin"
git clone origin ana 2>/dev/null
cd ana
git config user.name "Ana"
git config user.email "ana@ejemplo.com"
cd ..

cmd "# 4. Luis clona desde origin"
git clone origin luis 2>/dev/null
cd luis
git config user.name "Luis"
git config user.email "luis@ejemplo.com"
cd ..

rm -rf semilla

cmd "ls -d */"
ls -d */ | output

echo -e "  ${DIM}origin/  ana/  luis/  — tres copias del mismo historial${RESET}"
pausa

# ── Ana hace un cambio ──
cd ana

echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
echo "3. Demo"        >> agenda.txt

show_file "agenda.txt · Ana agrega Demo" agenda.txt

cmd "git add agenda.txt && git commit -m \"agrega demo\""
git add agenda.txt
git commit -m "agrega demo" | output

cmd "git push"
git push 2>&1 | output

cd ..

echo -e "  ${DIM}El commit de Ana ya está en origin. Luis aún no lo ve.${RESET}"
pausa

# ── fetch vs pull ──
cd luis

cmd "# Luis hace fetch: trae referencias, no modifica archivos"
git fetch 2>&1 | output

echo ""
show_file "agenda.txt · después de fetch (sin cambios)" agenda.txt

cmd "git log --oneline"
git log --oneline | output

echo -e "  ${DIM}Fetch no tocó agenda.txt ni movió HEAD. Solo bajó las referencias.${RESET}"
pausa

cmd "# Luis hace pull: fetch + integrar"
git pull 2>&1 | output

echo ""
show_file "agenda.txt · después de pull (con cambios)" agenda.txt

cmd "git log --oneline"
git log --oneline | output

cd ..

pausa

# ── Luis hace push ──
cd luis

echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
echo "3. Demo"        >> agenda.txt
echo "4. Cierre"      >> agenda.txt

cmd "git add agenda.txt && git commit -m \"agrega cierre\""
git add agenda.txt
git commit -m "agrega cierre" | output

cmd "git push"
git push 2>&1 | output

cd ..

# ── Ana hace pull ──
cd ana

cmd "# Ana hace pull para ver el cierre de Luis"
git pull 2>&1 | output

echo ""
show_file "agenda.txt · Ana ve el cierre de Luis" agenda.txt

cmd "git log --oneline"
git log --oneline | output

cd ..

echo ""
pie "4 movimientos: clone (una vez), fetch (seguro), pull (integra), push (publica)"
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
