#!/usr/bin/env bash
# demo-ramas.sh — Diapositiva 10: Una rama es un marcador
# Crea rama ana, trabaja en paralelo con main, visualiza el grafo.

set -e

DIR="workspace-slides/10-ramas"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "10" "Una rama es un marcador, no una copia de carpeta"

concepto "Crear una rama es mover un nombre para trabajar con libertad." \
  "No duplica el proyecto. Es un marcador que apunta a un commit."

pausa

cmd "git init && git branch -m main"
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

cmd "git log --oneline"
git log --oneline | output

pausa

# Crear rama ana
cmd "git branch ana"
git branch ana

cmd "git branch"
git branch | output

echo -e "  ${DIM}main y ana apuntan al mismo commit. No se duplicó nada.${RESET}"
pausa

# Trabajar en ana
cmd "git switch ana"
git switch ana | output

echo "1. Bienvenida"                   > agenda.txt
echo "2. Demo con archivos de texto"  >> agenda.txt
echo "3. Preguntas"                   >> agenda.txt
echo "4. Cierre"                      >> agenda.txt

show_file "agenda.txt · trabajo en ana" agenda.txt

cmd "git add agenda.txt && git commit -m \"agrega sección de cierre\""
git add agenda.txt
git commit -m "agrega sección de cierre" | output

pausa

# Volver a main: el cambio no está
cmd "git switch main"
git switch main | output

echo ""
show_file "agenda.txt · en main (sin el cierre de ana)" agenda.txt

echo -e "  ${DIM}main no tiene 'Cierre'. Ana trabajó en su rama sin afectar main.${RESET}"
pausa

# Divergir
cmd "git switch -c luis"
git switch -c luis | output

echo "1. Bienvenida"                   > agenda.txt
echo "2. Demo con archivos de texto"  >> agenda.txt
echo "3. Preguntas"                   >> agenda.txt
echo "4. Ronda de preguntas"          >> agenda.txt

show_file "agenda.txt · trabajo en luis" agenda.txt

cmd "git add agenda.txt && git commit -m \"agrega ronda de preguntas\""
git add agenda.txt
git commit -m "agrega ronda de preguntas" | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo ""
echo -e "  ${DIM}ana diverge de main/luis. Cada rama apunta a commits distintos.${RESET}"

pausa

pie "Ramas = marcadores. El historial (commits) es lo que importa. Las ramas solo los señalan."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
