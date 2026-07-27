#!/usr/bin/env bash
# run-all.sh — Ejecuta todos los demos en secuencia
# Uso: bash helpers/demos/run-all.sh
#      SKIP_PAUSE=1 bash helpers/demos/run-all.sh  (sin pausas)
#
# Fuente: helpers/demos/run-all.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/../lib"

source "$LIB_DIR/logger.sh"

DEMOS=(
  "07-commits"
  "10-ramas"
  "14-remotes"
  "17-merge"
  "19-rebase"
  "21-ffonly"
  "22-conflictos"
  "26-laboratorio"
)

PASADOS=0
FALLIDOS=0

echo ""
echo -e "  ${BOLD}${CYAN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "  ${BOLD}${CYAN}║${RESET} ${BOLD}Ejecutando todos los demos del taller${RESET}                         ${BOLD}${CYAN}║${RESET}"
echo -e "  ${BOLD}${CYAN}║${RESET} ${DIM}${#DEMOS[@]} demos · SKIP_PAUSE=${SKIP_PAUSE:-0}${RESET}                                          ${BOLD}${CYAN}║${RESET}"
echo -e "  ${BOLD}${CYAN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

for demo in "${DEMOS[@]}"; do
  demo_path="$SCRIPT_DIR/${demo}.sh"

  if [ ! -f "$demo_path" ]; then
    echo -e "  ${RED}✗${RESET} ${demo} — no encontrado"
    ((FALLIDOS++))
    continue
  fi

  echo -e "  ${CYAN}▶${RESET} Ejecutando ${BOLD}${demo}${RESET}..."

  if [ "${SKIP_PAUSE:-0}" = "1" ]; then
    if yes "" 2>/dev/null | bash -c "source $LIB_DIR/logger.sh && source $demo_path" 2>&1 | tail -3 | grep -q "✓"; then
      echo -e "    ${GREEN}✓${RESET} ${demo} completado"
      ((PASADOS++))
    else
      echo -e "    ${RED}✗${RESET} ${demo} falló"
      ((FALLIDOS++))
    fi
  else
    if bash -c "source $LIB_DIR/logger.sh && source $demo_path" 2>&1; then
      ((PASADOS++))
    else
      echo -e "    ${RED}✗${RESET} ${demo} falló"
      ((FALLIDOS++))
    fi
  fi

  echo ""
done

echo -e "  ${BOLD}══════════════════════════════════════════════════════════════${RESET}"
echo -e "  ${GREEN}Pasados:${RESET} ${PASADOS}  ${RED}Fallidos:${RESET} ${FALLIDOS}  ${DIM}Total:${RESET} ${#DEMOS[@]}"
echo -e "  ${DIM}Workspace: workspace-slides/${RESET}"
echo ""
