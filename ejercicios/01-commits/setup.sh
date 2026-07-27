#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-01"

if [ -d "$EJERCICIO_DIR" ]; then
  echo "La carpeta '$EJERCICIO_DIR' ya existe. ¿Quieres recrearla? (s/N)"
  read -r respuesta
  if [ "$respuesta" != "s" ] && [ "$respuesta" != "S" ]; then
    echo "Usa la carpeta existente."
    exit 0
  fi
  rm -rf "$EJERCICIO_DIR"
fi

mkdir -p "$EJERCICIO_DIR"
cp agenda.txt "$EJERCICIO_DIR/"

cd "$EJERCICIO_DIR"

echo "=== Inicializando repositorio ==="
git init
git branch -m main

echo ""
echo "=== Repositorio listo ==="
echo "Carpeta: $(pwd)"
echo ""
echo "Sigue las instrucciones del README.md para crear los 3 commits."
echo "Tip: empieza con 'git status' para ver en qué lugar estás."
