#!/usr/bin/env bash
# Genera docs/presentacion/geometria-fractal-presentacion.pdf (16:9) desde docs/build/slides.html
# Requiere google-chrome. Uso: bash docs/build/build-slides.sh
set -euo pipefail
cd "$(dirname "$0")/.."
google-chrome --headless=new --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=presentacion/geometria-fractal-presentacion.pdf "file://$PWD/build/slides.html" 2>/dev/null
echo "OK: docs/presentacion/geometria-fractal-presentacion.pdf"
