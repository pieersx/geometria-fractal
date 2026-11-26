#!/usr/bin/env bash
# Genera las figuras comparativas del módulo 4 (misma semilla, un parámetro distinto) en docs/presentacion/capturas/
# Requiere google-chrome. Uso: bash docs/build/capturas-modulo4.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/docs/presentacion/capturas"
TMP="$(mktemp -d)"
shot() { # nombre rugosidad paleta [preset]
  local name="$1" rough="$2" pal="$3" water="${4:-0.3}"
  python3 - "$ROOT/modulos/04-terreno-fractal/index.html" "$TMP/$name.html" "$rough" "$pal" "$water" <<'PY'
import sys
src,dst,rough,pal,water=sys.argv[1:]
h=open(src,encoding='utf8').read()
js=f"""<script>window.addEventListener('load',()=>setTimeout(()=>{{
const u=i=>document.getElementById(i);
u('orbit').checked=false;u('orbit').dispatchEvent(new Event('change'));
u('rough').value={rough};u('rough').dispatchEvent(new Event('input'));
u('pal').value='{pal}';u('pal').dispatchEvent(new Event('change'));
u('water').value={water};u('water').dispatchEvent(new Event('input'));
u('panel').style.display='none';}},400));</script></body>"""
open(dst,'w',encoding='utf8').write(h.replace('</body>',js))
PY
  google-chrome --headless=new --no-sandbox --use-angle=swiftshader --enable-unsafe-swiftshader --ignore-gpu-blocklist \
    --window-size=1000,640 --virtual-time-budget=12000 --screenshot="$OUT/$name.png" "file://$TMP/$name.html" >/dev/null 2>&1
  echo "  $name.png"
}
shot modulo4-rugosidad-040 0.40 alpine
shot modulo4-rugosidad-059 0.59 alpine
shot modulo4-rugosidad-080 0.80 alpine
shot modulo4-paleta-desierto 0.59 desert 0.1
shot modulo4-paleta-violeta 0.59 violet
shot modulo4-paleta-artico 0.59 arctic
