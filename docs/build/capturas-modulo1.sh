#!/usr/bin/env bash
# Genera figuras comparativas del módulo 1 (zoom progresivo, tres conjuntos de Julia y el límite de precisión)
# en docs/presentacion/capturas/. Requiere google-chrome. Uso: bash docs/build/capturas-modulo1.sh
# (MODULO1_HTML=ruta/index.html para usar otra copia del módulo)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/docs/presentacion/capturas"
TMP="$(mktemp -d)"
shot() { # nombre "código JS que fija el estado" [mostrar_panel 0|1]
  local name="$1" code="$2" panel="${3:-0}" hide="u('panel').style.display='none';"
  [ "$panel" = 1 ] && hide=""
  python3 - "${MODULO1_HTML:-$ROOT/modulos/01-conjuntos-escape/index.html}" "$TMP/$name.html" "$code" "$hide" <<'PY'
import sys
src,dst,code,hide=sys.argv[1:]
h=open(src,encoding='utf8').read()
js=f"<script>window.addEventListener('load',()=>setTimeout(()=>{{const u=i=>document.getElementById(i);{code};{hide}}},400));</script></body>"
open(dst,'w',encoding='utf8').write(h.replace('</body>',js))
PY
  google-chrome --headless=new --no-sandbox --use-angle=swiftshader --enable-unsafe-swiftshader --ignore-gpu-blocklist \
    --window-size=1100,700 --virtual-time-budget=8000 --screenshot="$OUT/$name.png" "file://$TMP/$name.html" >/dev/null 2>&1
  echo "  $name.png"
}
ZOOM() { echo "state.cx=-0.7436;state.cy=0.1318;state.scale=$1;state.maxIter=$2;changed()"; }
shot modulo1-zoom-1 "state.maxIter=200;changed()"
shot modulo1-zoom-2 "$(ZOOM 0.05 400)"
shot modulo1-zoom-3 "$(ZOOM 0.002 900)"
JULIA() { echo "setMode(true);setC($1,$2);state.maxIter=300;changed()"; }
shot modulo1-julia-dragon "$(JULIA -0.8 0.156)"
shot modulo1-julia-dendrita "$(JULIA 0 1)"
shot modulo1-julia-conejo "$(JULIA -0.123 0.745)"
shot modulo1-limite-precision "$(ZOOM 0.00004 1200)" 1
# Modos didácticos: construcción por capas y órbita de un punto (ventana más alta para ver el panel)
shot modulo1-paso-01 "setBuild(true);setStep(1)" 1
shot modulo1-paso-04 "setBuild(true);setStep(4)" 1
shot modulo1-paso-12 "setBuild(true);setStep(12)" 1
shot modulo1-paso-40 "setBuild(true);setStep(40)" 1
shot modulo1-orbita-acotada "setOrbit(true);orbit.mx=520;orbit.my=320;drawOrbit()" 1
shot modulo1-orbita-escapa "setOrbit(true);orbit.mx=800;orbit.my=250;drawOrbit()" 1
# Versiones sin panel para la presentación
shot modulo1-paso-12-limpio "setBuild(true);setStep(12)"
shot modulo1-orbita-escapa-limpio "setOrbit(true);orbit.fixed=[0.723,0.277];drawOrbit()"
shot modulo1-dividida "setSplit(true);setSplitPoint(-0.4,0.6)"
