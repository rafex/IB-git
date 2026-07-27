#!/usr/bin/env bash
# logger.sh — Funciones de salida con colores para los demos del taller
# Fuente: helpers/lib/logger.sh

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"

GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
MAGENTA="\033[35m"
RED="\033[31m"
WHITE="\033[37m"

# Cabecera de slide
slide_header() {
  local num="$1"
  local title="$2"
  echo ""
  echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════════════╗${RESET}"
  printf "${BOLD}${CYAN}║${RESET} ${BOLD}Diapositiva %-4s${RESET} ${WHITE}%-46s${RESET} ${BOLD}${CYAN}║${RESET}\n" "$num" "$title"
  echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

# Concepto clave (idea fuerza del slide)
concepto() {
  echo -e "  ${MAGENTA}▶${RESET} ${BOLD}$1${RESET}"
  echo -e "    ${DIM}$2${RESET}"
  echo ""
}

# Comando que se va a ejecutar
cmd() {
  echo -e "  ${GREEN}\$${RESET} ${BOLD}$1${RESET}"
}

# Salida de un comando (indentada)
output() {
  while IFS= read -r line; do
    echo -e "    ${DIM}${line}${RESET}"
  done
}

# Archivo que se muestra (tipo cat con formato)
show_file() {
  local label="$1"
  local file="$2"
  echo -e "  ${YELLOW}┌─ ${label} ──────────────────────────────${RESET}"
  while IFS= read -r line; do
    echo -e "  ${YELLOW}│${RESET} ${WHITE}${line}${RESET}"
  done < "$file"
  echo -e "  ${YELLOW}└────────────────────────────────────────${RESET}"
  echo ""
}

# Pausa para que el usuario lea
pausa() {
  echo ""
  echo -e "  ${DIM}Presiona Enter para continuar...${RESET}"
  read -r
  echo ""
}

# Pie de demo
pie() {
  echo -e "  ${CYAN}✓${RESET} ${DIM}$1${RESET}"
  echo ""
}
