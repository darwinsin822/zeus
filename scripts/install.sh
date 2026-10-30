#!/usr/bin/env bash
# ==============================================================================
# Zeus — Instalador Automatizado e Idempotente para Google Antigravity
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="${HOME}/.gemini/config/skills/zeus"

echo "⚡ Instalando la skill Zeus en Google Antigravity..."

mkdir -p "$TARGET_DIR"
cp -u "$REPO_DIR/SKILL.md" "$TARGET_DIR/SKILL.md"

if [ -f "$REPO_DIR/assets/zeus.jpg" ]; then
  mkdir -p "$TARGET_DIR/assets"
  cp -u "$REPO_DIR/assets/zeus.jpg" "$TARGET_DIR/assets/zeus.jpg"
fi

echo "✔ Zeus instalado correctamente en: $TARGET_DIR"
echo "  Disponible en Antigravity mediante la invocación: 'zeus', 'modo zeus' o 'invoca a zeus'."
