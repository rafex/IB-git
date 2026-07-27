#!/usr/bin/env bash
# demo-commits.sh — Diapositiva 07: Sigamos un archivo de texto
# Muestra cómo Git guarda instantáneas con agenda.txt a través de 3 commits.

set -e

DIR="workspace-slides/07-commits"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "07" "Sigamos un archivo de texto"

concepto "Git guarda instantáneas, no diferencias entre carpetas." \
  "Cada commit describe cómo estaba el proyecto en un momento y apunta a su antecesor."

pausa

cmd "git init"
git init | output
git branch -m main

echo ""

# ── Commit A ──
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt

show_file "agenda.txt · estado inicial" agenda.txt

cmd "git add agenda.txt"
git add agenda.txt

cmd "git commit -m \"agrega agenda inicial\""
git commit -m "agrega agenda inicial" | output

cmd "git log --oneline"
git log --oneline | output

pausa

# ── Commit B ──
echo "1. Bienvenida"                   > agenda.txt
echo "2. Demo con archivos de texto"  >> agenda.txt
echo "3. Preguntas"                   >> agenda.txt

show_file "agenda.txt · commit B" agenda.txt

cmd "git add agenda.txt && git commit -m \"agrega demo con archivos de texto\""
git add agenda.txt
git commit -m "agrega demo con archivos de texto" | output

cmd "git log --oneline"
git log --oneline | output

pausa

# ── Commit C ──
echo "1. Bienvenida"                   > agenda.txt
echo "2. Preguntas"                   >> agenda.txt
echo "3. Demo con archivos de texto"  >> agenda.txt

show_file "agenda.txt · commit C" agenda.txt

cmd "git add agenda.txt && git commit -m \"reordena cierre: preguntas antes de la demo\""
git add agenda.txt
git commit -m "reordena cierre: preguntas antes de la demo" | output

echo ""
cmd "git log --oneline"
git log --oneline | output

echo ""
cmd "git log"
git log | output

pausa

# Bonus: viaje en el tiempo
cmd "git show HEAD~2:agenda.txt"
echo -e "    ${DIM}(Así estaba agenda.txt hace 2 commits)${RESET}"
git show HEAD~2:agenda.txt | output

echo ""
pie "3 commits. 3 instantáneas. Puedes volver a cualquiera con git show <hash>:agenda.txt"
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
