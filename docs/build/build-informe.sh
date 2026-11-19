#!/usr/bin/env bash
# Genera docs/informe/informe-geometria-fractal.pdf a partir de los capítulos .md
# Requiere: pandoc y google-chrome. Uso: bash docs/build/build-informe.sh
set -euo pipefail
cd "$(dirname "$0")/../informe"
TMP="$(mktemp -d)"
strip() { grep -v '^> \*\*Estado' "$1"; }
{
  strip presentacion-resumen.md | sed '1s/.*/# Presentación/'
  for f in capitulo-1 capitulo-2 capitulo-3 capitulo-4 capitulo-5 capitulo-6 descripcion-app conclusion; do
    echo; strip "$f.md"
  done
  echo; echo '# Bibliografía'; echo; echo '::: bib'
  # solo la lista de referencias: sin la cita inicial ni las notas de verificación
  awk '/^## Notas de verificación/{exit} /^> /{next} NR>1' bibliografia.md
  echo ':::'
  echo; sed 's/^# Bitácora de uso de IA/# Anexo. Bitácora de uso de IA/' ../bitacora-ia.md
} > "$TMP/master.md"
pandoc "$TMP/master.md" -f markdown+smart -t html5 --standalone --embed-resources \
  --toc --toc-depth=1 --metadata pagetitle="Geometría fractal" --metadata toc-title=Índice --metadata lang=es \
  --css ../build/informe.css --include-before-body ../build/portada.html \
  --resource-path=. -o "$TMP/informe.html"
google-chrome --headless=new --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=informe-geometria-fractal.pdf "file://$TMP/informe.html" 2>/dev/null
echo "OK: docs/informe/informe-geometria-fractal.pdf"
