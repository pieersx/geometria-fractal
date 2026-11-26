# Módulo 5 · Dimensión fractal

**Responsable:** Puente Carmen, Rodrigo Joaquin
**Estado:** prototipo listo para revisión (versión base escrita el 26/11/2026; el responsable la revisa, la explica y ajusta el capítulo 6)

## Qué hace

- Mide la dimensión fractal D por **conteo de cajas**: cubre la imagen con mallas de lado 2^k, cuenta las cajas que tocan la figura, N(s), y ajusta una recta a ln N(s) frente a ln(1/ε). La pendiente es D.
- **Figuras de prueba** con dimensión conocida: línea (1), cuadrado relleno (2), **curva de Koch** (ln 4 / ln 3 ≈ 1,262, generada con la regla F→F+F−−F+F del módulo 3) y **triángulo de Sierpinski** (ln 3 / ln 2 ≈ 1,585).
- **Costa generada** por desplazamiento del punto medio, con rugosidad ajustable: a más rugosidad, mayor D (caso práctico de Mandelbrot, 1967).
- **Imagen propia:** se binariza con un umbral calculado con el método de Otsu, que se puede mover. Casilla para objeto oscuro sobre fondo claro y para medir solo el contorno.
- Un deslizador de tamaño de caja muestra en la figura las cajas ocupadas y marca ese punto en la gráfica log–log.
- Muestra D, R², N(s) y, en las figuras de prueba, el valor teórico y el error.

## Validación (imagen de trabajo de 1024 × 1024 px, escalas s = 8 … 64 px)

| Figura | D teórica | D medida | Error |
|---|---|---|---|
| Línea recta | 1,000 | 0,988 | 1,2 % |
| Curva de Koch | 1,262 | 1,264 | 0,2 % |
| Triángulo de Sierpinski | 1,585 | 1,535 | 3,2 % |
| Cuadrado relleno | 2,000 | 1,936 | 3,2 % |

Medido en el navegador el 26/11/2026. El error del cuadrado y de Sierpinski viene de que la figura ocupa pocas cajas en las escalas grandes y de la posición de la malla.

## Límites que hay que explicar

- El resultado depende del **umbral** y de si se mide el relleno o el contorno.
- Solo hay ley de potencias en un **rango de escalas**: con cajas menores que el grosor del trazo se mide el trazo; con cajas muy grandes, la figura cabe en pocas cajas.
- Es una **estimación**: un objeto natural no es autosimilar de forma infinita.

## Para el informe

Capítulo 6 (`docs/informe/capitulo-6.md`): sustituir el texto «planeado» por lo que hace la app, la tabla de validación y una captura por figura.
