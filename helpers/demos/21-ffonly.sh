#!/usr/bin/env bash
# demo-ffonly.sh — Diapositiva 21: ff-only, integrar sin bifurcación
# Muestra ff-only exitoso y su fallo cuando hay divergencia real.

set -e

DIR="workspace-slides/21-ffonly"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "21" "ff-only: integrar sin dibujar una bifurcación"

concepto "ff-only avanza el marcador sin crear merge commit. Es una baranda de seguridad." \
  "Falla si hay dos caminos que realmente necesitan decidirse."

pausa

# ── Caso 1: ff-only exitoso ──
git init | output
git branch -m main
echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
git add agenda.txt
git commit -m "agrega agenda inicial" | output

cmd "git switch -c adelante"
git switch -c adelante | output

echo "1. Bienvenida"  > agenda.txt
echo "2. Preguntas"   >> agenda.txt
echo "3. Contacto"    >> agenda.txt

show_file "agenda.txt · rama adelante" agenda.txt

git add agenda.txt
git commit -m "agrega contacto" | output

cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}adelante está un commit delante de main. No hay bifurcación.${RESET}"
pausa

cmd "git switch main"
git switch main | output
cmd "git merge --ff-only adelante"
git merge --ff-only adelante | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}main avanzó al mismo commit que adelante. Sin merge commit.${RESET}"
pausa

# ── Caso 2: ff-only falla ──
cmd "# Ahora creamos una divergencia real para ver ff-only fallar"

cmd "git switch -c rama-a"
git switch -c rama-a | output

echo "1. Bienvenida del equipo"  > agenda.txt
echo "2. Preguntas"             >> agenda.txt
echo "3. Contacto"              >> agenda.txt

git add agenda.txt
git commit -m "rama-a: cambia bienvenida" | output

cmd "git switch main"
git switch main | output

echo "1. Bienvenida general"  > agenda.txt
echo "2. Preguntas"          >> agenda.txt
echo "3. Contacto"           >> agenda.txt

git add agenda.txt
git commit -m "main: cambia bienvenida distinto" | output

cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}main y rama-a divergen. ff-only no puede resolver esto.${RESET}"
pausa

cmd "git merge --ff-only rama-a"
if git merge --ff-only rama-a 2>&1; then
  echo "inesperado" | output
else
  echo -e "    ${RED}fatal: Not possible to fast-forward, aborting.${RESET}"
  echo -e "    ${DIM}Git se niega: hay una bifurcación real que requiere decisión humana.${RESET}"
fi

echo ""
pie "ff-only = baranda de seguridad. No inventa integraciones ni resuelve conflictos por ti."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
