#!/usr/bin/env bash
# demo-laboratorio.sh — Diapositiva 26: Mini laboratorio con archivos de texto
# Simula el flujo completo: Ana y Luis colaboran con menu.txt en 3 rondas.

set -e

DIR="workspace-slides/26-laboratorio"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

slide_header "26" "Mini laboratorio: Ana y Luis colaboran"

concepto "Ciclo completo de colaboración: push, pull, conflicto y resolución." \
  "3 rondas progresivas con menu.txt."

pausa

# ── Infraestructura ──
mkdir semilla && cd semilla
git init | output
git branch -m main
git config pull.rebase false
cat > menu.txt << 'EOF'
1. Sopa
2. Pan
EOF
git add menu.txt
git commit -m "agrega menú inicial" | output
cd ..

git clone --bare semilla origin 2>/dev/null
git clone origin ana 2>/dev/null
git clone origin luis 2>/dev/null

cd ana && git config user.name "Ana" && git config user.email "ana@ejemplo.com" && cd ..
cd luis && git config user.name "Luis" && git config user.email "luis@ejemplo.com" && cd ..

rm -rf semilla

show_file "menu.txt · ambos empiezan igual" ana/menu.txt

echo -e "  ${DIM}origin/  ana/  luis/  — todos con el mismo menú inicial${RESET}"
pausa

# ── Ronda 1: Ana agrega ensalada ──
echo -e "  ${BOLD}${CYAN}── Ronda 1: Ana agrega una opción ──${RESET}"
echo ""

cd ana
echo "1. Sopa"       > menu.txt
echo "2. Pan"        >> menu.txt
echo "3. Ensalada"   >> menu.txt

cmd "[ana]  git add menu.txt && git commit -m \"agrega ensalada al menú\""
git add menu.txt
git commit -m "agrega ensalada al menú" | output

cmd "[ana]  git push"
git push 2>&1 | output
cd ..

cd luis
cmd "[luis] git pull"
git pull 2>&1 | output

show_file "menu.txt · Luis ya ve la ensalada" menu.txt
cd ..

pausa

# ── Ronda 2: Luis reordena ──
echo -e "  ${BOLD}${CYAN}── Ronda 2: Luis reordena el menú ──${RESET}"
echo ""

cd luis
echo "1. Sopa"       > menu.txt
echo "2. Ensalada"   >> menu.txt
echo "3. Pan"        >> menu.txt

cmd "[luis] git add menu.txt && git commit -m \"reordena menú: pan al final\""
git add menu.txt
git commit -m "reordena menú: pan al final" | output

cmd "[luis] git push"
git push 2>&1 | output
cd ..

cd ana
cmd "[ana]  git pull"
git pull 2>&1 | output

show_file "menu.txt · Ana ve el nuevo orden" menu.txt
cd ..

pausa

# ── Ronda 3: Conflicto ──
echo -e "  ${BOLD}${CYAN}── Ronda 3: Ambos editan la misma línea (conflicto) ──${RESET}"
echo ""

cd ana
echo "1. Sopa del día"  > menu.txt
echo "2. Ensalada"     >> menu.txt
echo "3. Pan"          >> menu.txt

cmd "[ana]  git add menu.txt && git commit -m \"especifica sopa del día\""
git add menu.txt
git commit -m "especifica sopa del día" | output
cmd "[ana]  git push"
git push 2>&1 | output
cd ..

cd luis
echo "1. Sopa de verduras"  > menu.txt
echo "2. Ensalada"         >> menu.txt
echo "3. Pan"              >> menu.txt

cmd "[luis] git add menu.txt && git commit -m \"especifica sopa de verduras\""
git add menu.txt
git commit -m "especifica sopa de verduras" | output

cmd "[luis] git fetch origin"
git fetch origin 2>&1 | output
cmd "[luis] git merge origin/main"
echo -e "  ${RED}(Conflicto: ambos cambiaron 'Sopa' por algo distinto)${RESET}"
if git merge origin/main 2>&1; then
  echo "inesperado" | output
else
  echo -e "    ${RED}CONFLICT (content): Merge conflict in menu.txt${RESET}"
  echo -e "    ${DIM}git pull = git fetch + git merge. Aquí usamos fetch+merge para ver cada paso.${RESET}"
fi

echo ""
cmd "[luis] cat menu.txt  (con marcadores)"
echo -e "  ${YELLOW}┌─ menu.txt ────────────────────────────────${RESET}"
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
done < menu.txt
echo -e "  ${YELLOW}└──────────────────────────────────────────${RESET}"

pausa

# ── Resolver ──
cmd "[luis] Resuelve: conserva 'Sopa de verduras'"
echo "1. Sopa de verduras"  > menu.txt
echo "2. Ensalada"         >> menu.txt
echo "3. Pan"              >> menu.txt

show_file "menu.txt · decisión de Luis" menu.txt

cmd "[luis] git add menu.txt && git commit -m \"resuelve: conserva sopa de verduras\""
git add menu.txt
git commit -m "resuelve: conserva sopa de verduras" | output

cmd "[luis] git push"
git push 2>&1 | output
cd ..

cd ana
cmd "[ana]  git pull"
git pull 2>&1 | output

show_file "menu.txt · Ana ve la decisión final" menu.txt
cd ..

echo ""
cmd "# Historial final en origin"
cd ana
git log --oneline | output
cd ..

echo ""
pie "3 rondas. Commits pequeños y frecuentes → integración sencilla, conflictos manejables."
echo -e "  ${DIM}Workspace: ${DIR}/${RESET}"
