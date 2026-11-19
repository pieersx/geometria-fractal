"""Genera un código QR (SVG) por módulo hacia la aplicación publicada.
Requiere: pip install qrcode.  Uso: python3 docs/build/qr.py
"""
import pathlib, qrcode, qrcode.image.svg

BASE = "https://pieersx.github.io/geometria-fractal/"
MODULOS = {
    1: "modulos/01-conjuntos-escape/",
    2: "modulos/02-ifs-chaos-game/",
    3: "modulos/03-l-systems/",
    4: "modulos/04-terreno-fractal/",
    5: "modulos/05-dimension-fractal/",
}
out = pathlib.Path(__file__).resolve().parent.parent / "informe" / "img"
for n, ruta in MODULOS.items():
    img = qrcode.make(BASE + ruta, image_factory=qrcode.image.svg.SvgPathImage, border=1)
    img.save(out / f"qr-modulo-{n}.svg")
    print(f"qr-modulo-{n}.svg  ->  {BASE + ruta}")
