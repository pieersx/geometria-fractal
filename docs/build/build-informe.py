#!/usr/bin/env python3
"""Genera docs/informe/informe-geometria-fractal.pdf desde los capítulos .md.

Requiere: pandoc (>= 3.1), google-chrome y ghostscript (gs). Uso:  python3 docs/build/build-informe.py

Compila en varias pasadas: genera el PDF con números de página provisionales, lee en qué página cayó
cada encabezado, figura y tabla (fichas invisibles QQTnQQ) y vuelve a generar con el índice y las listas
de figuras y tablas ya numerados, hasta que no cambien.
"""
import html, os, pathlib, re, shutil, subprocess, sys, tempfile

BUILD = pathlib.Path(__file__).resolve().parent
INFORME = BUILD.parent / "informe"
SALIDA = INFORME / "informe-geometria-fractal.pdf"
CAPITULOS = ["capitulo-1", "capitulo-2", "capitulo-3", "capitulo-4", "capitulo-5", "capitulo-6",
             "descripcion-app", "capitulo-8", "conclusion"]


def sin_estado(path):
    """Quita las notas internas '> **Estado:** ...' que no van en el informe final."""
    return [l for l in path.read_text(encoding="utf8").splitlines() if not l.startswith("> **Estado")]


def armar_master():
    out = []
    out += ["# Presentación"] + sin_estado(INFORME / "presentacion-resumen.md")[1:]
    for c in CAPITULOS:
        lineas = sin_estado(INFORME / f"{c}.md")
        if any("por medir" in l or "por completar" in l for l in lineas):
            print(f"  aviso: {c}.md tiene datos pendientes (por medir/por completar); no se incluye en el PDF")
            continue
        out += [""] + lineas
    out += ["", "# Bibliografía", "", "::: bib"]
    bib = (INFORME / "bibliografia.md").read_text(encoding="utf8").splitlines()
    for l in bib[1:]:
        if l.startswith("## Notas de verificación"):
            break
        if l.startswith("> "):
            continue
        out.append(l)
    out += [":::", ""]
    bit = (BUILD.parent / "bitacora-ia.md").read_text(encoding="utf8")
    bit = bit.replace("# Bitácora de uso de IA", "# Anexo. Bitácora de uso de IA", 1).replace("__:__", r"\_\_:\_\_")
    out += [l for l in bit.splitlines() if not l.startswith("Completa la hora")]
    return "\n".join(out) + "\n"


def leer_entradas(tsv):
    filas = []
    for l in tsv.read_text(encoding="utf8").splitlines():
        kind, level, num, tok, text = l.split("\t", 4)
        filas.append(dict(kind=kind, level=int(level or 0), num=num, tok=int(tok), text=text))
    return filas


def fila(texto, pagina, nivel=1, negrita=False, tok=None):
    cls = f"row l{nivel}" + (" b" if negrita else "")
    div = (f'<div class="{cls}"><span class="rt">{html.escape(texto)}</span><span class="dots"></span>'
           f'<span class="pg">{pagina}</span></div>')
    # enlace interno: pulsar la fila lleva a la sección, figura o tabla
    return f'<a class="rowlink" href="#t{tok}">{div}</a>' if tok is not None else div


def armar_front(entradas, paginas):
    pg = lambda e: paginas.get(e["tok"], "00")
    h = ['<div class="ft">Índice</div>']
    for e in entradas:
        if e["kind"] == "h":
            h.append(fila(e["text"], pg(e), e["level"], e["level"] == 1, e["tok"]))
    h.append('<div class="ft brk">Lista de figuras</div>')
    for e in entradas:
        if e["kind"] == "f":
            h.append(fila(f'Figura {e["num"]}. {e["text"]}', pg(e), tok=e["tok"]))
    h.append('<div class="ft">Lista de tablas</div>')
    for e in entradas:
        if e["kind"] == "t":
            h.append(fila(f'Tabla {e["num"]}. {e["text"]}', pg(e), tok=e["tok"]))
    return '<div class="front">' + "\n".join(h) + "</div>"


def paginas_del_pdf(pdf, tmp):
    carpeta = tmp / "txt"
    carpeta.mkdir(exist_ok=True)
    for f in carpeta.glob("*.txt"):
        f.unlink()
    gs = shutil.which("gs") or shutil.which("gswin64c") or "gs"
    subprocess.run([gs, "-q", "-dNOPAUSE", "-dBATCH", "-sDEVICE=txtwrite",
                    f"-sOutputFile={carpeta}/p%03d.txt", str(pdf)], check=True)
    paginas = {}
    for f in sorted(carpeta.glob("p*.txt")):
        n = int(f.stem[1:])
        for t in re.findall(r"QQT(\d+)QQ", f.read_text(encoding="utf8", errors="ignore")):
            paginas.setdefault(int(t), n)
    return paginas


def chrome():
    """Ruta de Chrome en Linux, macOS o Windows (o la variable de entorno CHROME)."""
    candidatos = [os.environ.get("CHROME"), shutil.which("google-chrome"), shutil.which("chrome"),
                  r"C:\Program Files\Google\Chrome\Application\chrome.exe",
                  r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
                  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"]
    for c in candidatos:
        if c and pathlib.Path(c).exists():
            return c
    sys.exit("No se encontró Google Chrome; define la variable CHROME con su ruta.")


def imprimir(html_path, pdf):
    subprocess.run([chrome(), "--headless=new", "--no-sandbox", "--disable-gpu", "--no-pdf-header-footer",
                    "--generate-pdf-document-outline", f"--print-to-pdf={pdf}", pathlib.Path(html_path).as_uri()], check=True,
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def main():
    tmp = pathlib.Path(tempfile.mkdtemp())
    master, base_html, tsv = tmp / "master.md", tmp / "base.html", tmp / "entradas.tsv"
    master.write_text(armar_master(), encoding="utf8")
    env = dict(os.environ, ENTRIES_TSV=str(tsv))
    subprocess.run(["pandoc", str(master), "-f", "markdown+smart+autolink_bare_uris", "-t", "html5", "--standalone",
                    "--embed-resources", "--mathml", "--lua-filter", str(BUILD / "apa.lua"),
                    "--metadata", "pagetitle=Geometría fractal", "--metadata", "lang=es",
                    "--css", str(BUILD / "informe.css"), "--include-before-body", str(BUILD / "portada.html"),
                    "--resource-path", str(INFORME), "-o", str(base_html)], check=True, env=env, cwd=INFORME)
    entradas = leer_entradas(tsv)
    base = base_html.read_text(encoding="utf8")
    # Logo opcional de la portada: si existe docs/build/logo-unmsm.(png|svg|jpg), se incluye; si no, la portada sale sin logo
    logo = next((f for e in ("png", "svg", "jpg") if (f := BUILD / f"logo-unmsm.{e}").exists()), None)
    base = base.replace("<!--LOGO-->", f'<img class="logo" src="{logo.as_uri()}" alt="Logo de la Universidad Nacional Mayor de San Marcos">' if logo else "")
    assert "<!--FRONT-->" in base, "falta el marcador <!--FRONT--> en portada.html"
    paginas, previo = {}, None
    for vuelta in range(1, 5):
        final = tmp / "informe.html"
        final.write_text(base.replace("<!--FRONT-->", armar_front(entradas, paginas)), encoding="utf8")
        imprimir(final, SALIDA)
        paginas = paginas_del_pdf(SALIDA, tmp)
        print(f"  pasada {vuelta}: {len(paginas)} fichas localizadas")
        if paginas == previo:
            break
        previo = paginas
    faltan = [e["text"] for e in entradas if e["tok"] not in paginas]
    if faltan:
        sys.exit(f"No se localizó la página de: {faltan}")
    n = max(paginas_del_pdf(SALIDA, tmp).values())
    print(f"OK: {SALIDA.relative_to(BUILD.parent.parent)} (última ficha en la página {n})")


if __name__ == "__main__":
    main()
