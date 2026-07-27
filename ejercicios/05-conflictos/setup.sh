#!/usr/bin/env bash
set -euo pipefail

EJERCICIO_DIR="taller-05"

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
cp acuerdos.txt "$EJERCICIO_DIR/"

cd "$EJERCICIO_DIR"

echo "=== Preparando repositorio con ramas conflictivas ==="

git init
git branch -m main

# Commit base
git add acuerdos.txt
git commit -m "agrega acuerdos iniciales"

# Rama ana: cambia la última línea
git branch ana
git switch ana

cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Confirmar asistencia antes del evento
EOF

git add acuerdos.txt
git commit -m "ana: agrega confirmación de asistencia"

# Rama luis: cambia la misma línea
git switch main
git branch luis
git switch luis

cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Preparar sala virtual
EOF

git add acuerdos.txt
git commit -m "luis: agrega preparación de sala virtual"

# Volver a main para empezar el ejercicio
git switch main

echo ""
echo "=== Repositorio listo ==="
echo "Carpeta: $(pwd)"
echo ""
echo "Estado inicial (ana y luis divergen desde el mismo punto):"
git log --oneline --graph --all
echo ""
echo "Sigue las instrucciones del README.md."
echo "Tip: empieza con 'git diff main ana' y 'git diff main luis'."
