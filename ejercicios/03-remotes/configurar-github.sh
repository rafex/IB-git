#!/usr/bin/env bash
set -euo pipefail

echo "=== Configurar GitHub como remote ==="
echo ""
echo "Este script reconfigura los clones para usar un repo real de GitHub."
echo "Necesitas:"
echo "  1. Cuenta de GitHub"
echo "  2. gh CLI instalada (gh auth login)"
echo "  3. O crear el repo manualmente y copiar la URL"
echo ""

BASE_DIR="$(cd taller-03 && pwd)"

echo "Opciones:"
echo "  [1] Usar gh CLI (recomendado)"
echo "  [2] Usar URL manual (pegar URL de repo existente)"
echo ""
read -rp "Elige una opción (1/2): " opcion

get_url() {
  case "$opcion" in
    1)
      if ! command -v gh &>/dev/null; then
        echo "gh CLI no está instalada. Instálala: https://cli.github.com/"
        exit 1
      fi
      echo "Creando repo en GitHub..."
      REPO_NAME="taller-git-remotos-$(date +%s)"
      gh repo create "$REPO_NAME" --private --clone 2>/dev/null || {
        echo "Error al crear el repo. ¿Hiciste gh auth login?"
        exit 1
      }
      echo "https://github.com/\$(gh api user --jq .login)/$REPO_NAME.git"
      ;;
    2)
      read -rp "Pega la URL del repo (termina en .git): " url
      echo "$url"
      ;;
    *)
      echo "Opción inválida"
      exit 1
      ;;
  esac
}

URL=$(get_url)

echo ""
echo "Reconfigurando remotos de ana y luis..."

for clon in ana luis; do
  cd "$BASE_DIR/$clon"
  git remote remove origin
  git remote add origin "$URL"
  echo "  $clon → $URL"
done

# Subir el historial base desde uno de los clones
cd "$BASE_DIR/ana"
git push -u origin main 2>/dev/null || {
  echo ""
  echo "El push inicial falló. Asegúrate de que:"
  echo "  - El repo de GitHub existe y está vacío"
  echo "  - Tienes permisos de escritura"
  echo "  - La URL es correcta: $URL"
  exit 1
}

echo ""
echo "=== Listo ==="
echo "Ambos clones ahora apuntan a: $URL"
echo "Continúa con el ejercicio del README.md."
