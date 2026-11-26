# Módulo 2 · IFS y Chaos Game

**Responsable:** Cerna Aguilar, Emily Andrea
**Estado:** prototipo listo para revisión (versión base escrita el 26/11/2026; la responsable la revisa, la explica y ajusta el capítulo 3)

## Qué hace

- **Helecho de Barnsley:** IFS de 4 transformaciones afines con probabilidades (0,01 · 0,85 · 0,07 · 0,07).
- **Triángulo de Sierpinski** por juego del caos: se elige al azar uno de 3 vértices y se salta una fracción r del camino hacia él.
- **Alfombra de Sierpinski** con 8 vértices y r = 1/3.
- Deslizador de **razón de salto r**: con r mayor que el límite (1/2 en el triángulo, 1/3 en la alfombra) las copias se solapan y el fractal se llena. La app lo avisa.
- Número de puntos de 1 000 a 5 millones; se descartan los 20 primeros y la imagen se acumula como densidad con escala logarítmica.
- Casilla para **colorear cada punto según la transformación** que lo dibujó, que muestra que cada regla genera una copia reducida del todo.
- Muestra la dimensión de semejanza ln n / ln(1/r) (1,585 en el triángulo, 1,893 en la alfombra). El helecho se puede medir con el módulo 5.

Sin modos paso a paso: el panel tiene solo ejemplo, r, puntos y una casilla.

## Para el informe

Capítulo 3 (`docs/informe/capitulo-3.md`): ajustar el texto a lo que hace la app y añadir capturas del helecho, del triángulo y de la alfombra.
