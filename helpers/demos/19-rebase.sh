#!/usr/bin/env bash
# demo-rebase.sh — Diapositiva 19: Rebase reacomoda una línea sobre otra
# Muestra cómo rebase reescribe commits sobre una base distinta.

set -e

DIR="workspace-slides/19-rebase"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "19" "Rebase: reacomoda una línea sobre otra"

concepto "Rebase reaplica tus commits sobre otra base. El historial queda lineal." \
  "Regla de oro: no hagas rebase de una rama que ya compartiste."

pausa

# ── Base ──
git init | output
git branch -m main
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
git add agenda.txt
git commit -m "agrega agenda inicial" | output

echo "1. Bienvenida"                   > agenda.txt
echo "2. Demo con archivos de texto"  >> agenda.txt
echo "3. Preguntas"                   >> agenda.txt
git add agenda.txt
git commit -m "agrega demo con archivos de texto" | output

echo ""
cmd "git log --oneline"
git log --oneline | output

pausa

# ── Crear feature desde el commit de demo ──
cmd "git switch -c feature"
git switch -c feature | output

echo "1. Bienvenida"                   > agenda.txt
echo "2. Demo con archivos de texto"  >> agenda.txt
echo "3. Preguntas"                   >> agenda.txt
echo "4. Cierre con feedback"         >> agenda.txt

show_file "agenda.txt · rama feature" agenda.txt

git add agenda.txt
git commit -m "agrega cierre con feedback" | output

pausa

# ── Alguien avanza main mientras tanto ──
cmd "git switch main"
git switch main
echo "1. Bienvenida"                         > agenda.txt
echo "2. Demo con archivos de texto y notas" >> agenda.txt
echo "3. Preguntas"                         >> agenda.txt

show_file "agenda.txt · main avanzó (modifica línea 2)" agenda.txt

git add agenda.txt
git commit -m "amplía demo con notas" | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}feature está detrás de main. Tiene un commit que main no tiene.${RESET}"
pausa

# ── Rebase ──
cmd "git switch feature"
git switch feature | output

cmd "git rebase main"
echo -e "  ${DIM}(Los commits de feature se reaplican sobre el main actual)${RESET}"
git rebase main 2>&1 | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}Historial lineal. El commit de feature cambió de hash (C → C').${RESET}"

show_file "agenda.txt · feature después del rebase" agenda.txt

pausa

echo "1. Bienvenida"                         > agenda.txt
echo "2. Demo con archivos de texto y notas" >> agenda.txt
echo "3. Preguntas"                         >> agenda.txt
echo "4. Cierre con feedback"              >> agenda.txt

echo -e "  ${DIM}Resultado: las líneas de ambas ramas se conservan en orden.${RESET}"
show_file "agenda.txt · combinación final" agenda.txt

echo ""
pie "Rebase = historial lineal. Merge = conserva el encuentro. Elige según el contexto."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
