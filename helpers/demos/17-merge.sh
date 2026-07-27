#!/usr/bin/env bash
# demo-merge.sh — Diapositiva 17: Merge conserva la historia de dos caminos
# Ana y Luis trabajan en líneas distintas, Git hace auto-merge.

set -e

DIR="workspace-slides/17-merge"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "17" "Integrar cambios: merge conserva la historia de dos caminos"

concepto "Merge crea un commit con dos padres: queda visible el encuentro de las ramas." \
  "Si tocaron líneas distintas, Git puede combinar automáticamente."

pausa

# ── Base ──
git init | output
git branch -m main
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
git add agenda.txt
git commit -m "agrega agenda inicial" | output

# ── Rama ana ──
git switch -c ana
echo "1. Bienvenida"                   > agenda.txt
echo "2. Preguntas"                   >> agenda.txt
echo "3. Ronda de preguntas"          >> agenda.txt

show_file "agenda.txt · rama ana" agenda.txt

git add agenda.txt
git commit -m "ana: agrega ronda de preguntas" | output

# ── Rama luis (desde main) ──
git switch main
git switch -c luis
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
echo "3. Notas"       >> agenda.txt

show_file "agenda.txt · rama luis" agenda.txt

git add agenda.txt
git commit -m "luis: agrega notas" | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}Dos ramas divergentes. Ana tocó línea 3, Luis tocó línea 3 también.${RESET}"
pausa

# ── Merge ana en main ──
git switch main

cmd "git merge ana"
echo -e "  ${DIM}(Ana y Luis tocaron líneas distintas → auto-merge exitoso)${RESET}"
git merge ana | output

echo ""
show_file "agenda.txt · después de mergear ana" agenda.txt

cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}Merge commit (M) con dos padres: main y ana.${RESET}"
pausa

# ── Ahora merge luis (también líneas distintas) ──
cmd "git merge luis"
git merge luis | output

echo ""
show_file "agenda.txt · después de mergear luis" agenda.txt

cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo ""
pie "Si las líneas editadas no se tocan, Git hace auto-merge sin intervención humana."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
