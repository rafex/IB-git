#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-04"

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

echo "=== Preparando repositorio con ramas divergentes ==="

git init
git branch -m main

git add agenda.txt
git commit -m "agrega agenda inicial"

# main: agrega demo
cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
EOF

git add agenda.txt
git commit -m "agrega demo con archivos de texto"

# feature (desde el commit de demo): agrega ronda
git branch feature
git switch feature

cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
4. Ronda de preguntas
EOF

git add agenda.txt
git commit -m "agrega ronda de preguntas"

# main: agrega cierre
git switch main

cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
4. Cierre
EOF

git add agenda.txt
git commit -m "agrega cierre"

echo ""
echo "=== Repositorio listo ==="
echo "Carpeta: $(pwd)"
echo ""
echo "Estado inicial (main y feature divergen):"
git log --oneline --graph --all
echo ""
echo "Sigue las instrucciones del README.md."
echo "Tip: empieza con 'git log --oneline --graph --all' para ver el escenario."
