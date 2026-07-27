#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-03"

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

echo "=== Modo: repositorio bare local ==="
echo ""

BASE_DIR="$(cd "$EJERCICIO_DIR" && pwd)"

echo "1. Creando repositorio inicial (semilla)..."

SEMILLA="$BASE_DIR/semilla"
mkdir -p "$SEMILLA"
cd "$SEMILLA"
git init
git branch -m main

cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
EOF

git add agenda.txt
git commit -m "agrega agenda inicial"

cat > agenda.txt << 'EOF'
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
EOF

git add agenda.txt
git commit -m "agrega sección de preguntas"

echo "2. Creando repositorio bare (origin)..."

ORIGIN="$BASE_DIR/origin"
git clone --bare "$SEMILLA" "$ORIGIN" 2>/dev/null

echo "3. Creando clon de Ana..."

ANA="$BASE_DIR/ana"
git clone "$ORIGIN" "$ANA" 2>/dev/null
cd "$ANA"
git config user.name "Ana"
git config user.email "ana@ejemplo.com"

echo "4. Creando clon de Luis..."

LUIS="$BASE_DIR/luis"
git clone "$ORIGIN" "$LUIS" 2>/dev/null
cd "$LUIS"
git config user.name "Luis"
git config user.email "luis@ejemplo.com"

echo "5. Limpiando semilla..."

rm -rf "$SEMILLA"

echo ""
echo "=== Repositorios listos ==="
echo ""
echo "Estructura creada:"
echo "  $BASE_DIR/origin/   ← repositorio bare (simula GitHub)"
echo "  $BASE_DIR/ana/      ← clon de Ana"
echo "  $BASE_DIR/luis/     ← clon de Luis"
echo ""
echo "Sigue las instrucciones del README.md."
echo ""
echo "Para usar GitHub real en vez del bare local:"
echo "  bash configurar-github.sh"
