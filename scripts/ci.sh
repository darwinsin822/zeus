#!/usr/bin/env bash
# ==============================================================================
# Zeus — Suite de Verificación Determinista e Integración Continua Local
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "🧪 [1/4] Validando sintaxis de scripts Bash..."
bash -n "$REPO_DIR/scripts/install.sh"
echo "  ✔ [PASS] scripts/install.sh sintaxis correcta."

echo "🧪 [2/4] Probando instalación en limpio hermética (Clean-Room)..."
TMP_HOME=$(mktemp -d)
HOME="$TMP_HOME" bash "$REPO_DIR/scripts/install.sh" >/dev/null
if [ -f "$TMP_HOME/.gemini/config/skills/zeus/SKILL.md" ] && [ -f "$TMP_HOME/.gemini/config/skills/zeus/assets/zeus.jpg" ]; then
  echo "  ✔ [PASS] Instalación aislada verificada con éxito."
else
  echo "  ❌ [FAIL] Error en la instalación aislada."
  rm -rf "$TMP_HOME"
  exit 1
fi
rm -rf "$TMP_HOME"

echo "🧪 [3/4] Validando metadatos y los 4 Pilares Soberanos en SKILL.md..."
grep -q "^name: zeus" "$REPO_DIR/SKILL.md"
grep -q "EL PROTOCOLO DE LOS 4 PILARES SOBERANOS" "$REPO_DIR/SKILL.md"
grep -q "Descubrimiento de Puntos Ciegos" "$REPO_DIR/SKILL.md"
echo "  ✔ [PASS] Frontmatter y pilares de Zeus validados."

echo "🧪 [4/4] Verificando ausencia total de rutas privadas absolutas..."
if git -C "$REPO_DIR" grep -I -i "/home/darwinsin" ":(exclude).git" 2>/dev/null; then
  echo "  ❌ [FAIL] Se detectaron rutas privadas absolutas."
  exit 1
else
  echo "  ✔ [PASS] 0 rutas privadas absolutas detectadas."
fi

echo ""
echo "✅ Todas las pruebas de CI de Zeus pasaron al 100% (Código de salida 0)."
