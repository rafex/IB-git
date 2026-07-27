#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-06"

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

BASE_DIR="$(cd "$EJERCICIO_DIR" && pwd)"

echo "=== Preparando entorno del laboratorio ==="

echo "1. Creando repositorio semilla..."

SEMILLA="$BASE_DIR/semilla"
mkdir -p "$SEMILLA"
cd "$SEMILLA"
git init
git branch -m main

cat > menu.txt << 'EOF'
1. Sopa
2. Pan
EOF

git add menu.txt
git commit -m "agrega menú inicial"

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
echo "=== Laboratorio listo ==="
echo ""
echo "Estructura creada:"
echo "  $BASE_DIR/origin/   ← repositorio bare (simula GitHub)"
echo "  $BASE_DIR/ana/      ← clon de Ana"
echo "  $BASE_DIR/luis/     ← clon de Luis"
echo ""
echo "Ambos ven el mismo menú inicial:"
echo ""
echo "  1. Sopa"
echo "  2. Pan"
echo ""
echo "Sigue las instrucciones del README.md."
echo ""
echo "Para usar GitHub real:"
echo "  Copia configurar-github.sh de ../03-remotes/ y adáptalo."
