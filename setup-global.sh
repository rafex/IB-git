#!/usr/bin/env bash
set -euo pipefail

echo "=== Verificando prerequisitos del taller ==="
echo ""

verificar() {
  local cmd="$1"
  local nombre="$2"

  if command -v "$cmd" &>/dev/null; then
    local version
    version=$("$cmd" --version 2>&1 | head -1)
    echo "  OK   $nombre — $version"
    return 0
  else
    echo "  FALTA $nombre — instálalo antes de continuar"
    return 1
  fi
}

errores=0

verificar git "Git" || ((errores++))
verificar bash "Bash" || ((errores++))

echo ""
if command -v code &>/dev/null; then
  echo "  OK   VS Code detectado"
elif command -v nano &>/dev/null; then
  echo "  OK   Nano detectado (editor de respaldo)"
elif command -v vim &>/dev/null; then
  echo "  OK   Vim detectado (editor de respaldo)"
else
  echo "  AVISO No se detectó editor de texto. Asegúrate de tener uno."
fi

echo ""

chmod_scripts() {
  find . -name "setup.sh" -exec chmod +x {} \; 2>/dev/null || true
  find . -name "configurar-github.sh" -exec chmod +x {} \; 2>/dev/null || true
  chmod +x setup-global.sh 2>/dev/null || true
}

chmod_scripts

if ((errores > 0)); then
  echo "Corrige los prerequisitos faltantes e intenta de nuevo."
  exit 1
fi

echo "=== Todo listo. Ve a ejercicios/ y empieza por 01-commits ==="
