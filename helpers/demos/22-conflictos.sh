#!/usr/bin/env bash
# demo-conflictos.sh — Diapositiva 22: ¿Cuándo aparece un conflicto?
# Crea un conflicto real en acuerdos.txt y muestra cómo resolverlo.

set -e

DIR="workspace-slides/22-conflictos"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "22" "¿Cuándo aparece un conflicto?"

concepto "Dos personas editaron la misma zona. Git no puede decidir por el equipo." \
  "La persona debe leer ambas versiones, elegir una combinación y crear un nuevo commit."

pausa

# ── Base ──
git init | output
git branch -m main
cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
EOF
git add acuerdos.txt
git commit -m "agrega acuerdos iniciales" | output

show_file "acuerdos.txt · base común" acuerdos.txt

pausa

# ── Rama ana ──
git switch -c ana
cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Confirmar asistencia antes del evento
EOF

show_file "acuerdos.txt · rama ana" acuerdos.txt

git add acuerdos.txt
git commit -m "ana: agrega confirmación de asistencia" | output

# ── Rama luis ──
git switch main
git switch -c luis
cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Preparar sala virtual
EOF

show_file "acuerdos.txt · rama luis" acuerdos.txt

git add acuerdos.txt
git commit -m "luis: agrega preparación de sala virtual" | output

cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo -e "  ${DIM}Ana y Luis editaron la misma línea (la 3). Va a haber conflicto.${RESET}"
pausa

# ── Merge ana (sin conflicto) ──
git switch main

cmd "git merge ana"
echo -e "  ${DIM}(Ana es la primera en integrarse → sin conflicto)${RESET}"
git merge ana | output

show_file "acuerdos.txt · después de mergear ana" acuerdos.txt

pausa

# ── Merge luis (conflicto) ──
cmd "git merge luis"
echo -e "  ${RED}(Conflicto: ambos tocaron la misma línea)${RESET}"
if git merge luis 2>&1; then
  echo "inesperado" | output
else
  echo -e "    ${RED}CONFLICT (content): Merge conflict in acuerdos.txt${RESET}"
  echo -e "    ${DIM}Automatic merge failed; fix conflicts and then commit the result.${RESET}"
fi

echo ""
cmd "cat acuerdos.txt"
echo -e "  ${YELLOW}┌─ acuerdos.txt CON marcadores de conflicto ──────${RESET}"
while IFS= read -r line; do
  if [[ "$line" == "<<<<<<<"* ]]; then
    echo -e "  ${RED}│ ${line}${RESET}"
  elif [[ "$line" == "======="* ]]; then
    echo -e "  ${YELLOW}│ ${line}${RESET}"
  elif [[ "$line" == ">>>>>>>"* ]]; then
    echo -e "  ${RED}│ ${line}${RESET}"
  else
    echo -e "  ${WHITE}│ ${line}${RESET}"
  fi
done < acuerdos.txt
echo -e "  ${YELLOW}└────────────────────────────────────────────${RESET}"

echo ""
echo -e "  ${DIM}<<<<<<< HEAD       → versión de ana (la que ya entró)${RESET}"
echo -e "  ${DIM}>>>>>>> luis       → versión de luis (la que intenta entrar)${RESET}"
echo -e "  ${DIM}=======            → separador entre versiones${RESET}"

pausa

# ── Resolver ──
cmd "# Resolver: editar el archivo, quitar marcadores, decidir qué conservar"
cat > acuerdos.txt << 'EOF'
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Confirmar asistencia antes del evento
- Preparar sala virtual
EOF

show_file "acuerdos.txt · decisión humana (ambas líneas)" acuerdos.txt

cmd "git add acuerdos.txt"
git add acuerdos.txt

cmd "git status"
git status | output

cmd "git commit -m \"resuelve conflicto: conserva ambas líneas del acuerdo\""
git commit -m "resuelve conflicto: conserva ambas líneas del acuerdo" | output

echo ""
cmd "git log --oneline --graph --all"
git log --oneline --graph --all | output

echo ""
pie "Resolver no es borrar marcas. Es tomar una decisión humana. Git integra texto; el equipo integra decisiones."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
