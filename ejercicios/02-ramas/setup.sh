#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-02"

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

echo "=== Preparando repositorio base ==="
git init
git branch -m main

git add agenda.txt
git commit -m "agrega agenda inicial"

# Estado B: agrega demo
cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
EOF

git add agenda.txt
git commit -m "agrega demo con archivos de texto"

echo ""
echo "=== Repositorio listo ==="
echo "Carpeta: $(pwd)"
echo "Commits en main:"
git log --oneline
echo ""
echo "Sigue las instrucciones del README.md para trabajar con ramas."
