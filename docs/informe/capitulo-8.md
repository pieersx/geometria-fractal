# Capítulo 8. Resultados experimentales

::: resumen
**Resumen del capítulo.** Se comprueba con mediciones propias que la aplicación calcula rápido: el mismo Mandelbrot tarda unas 25 veces menos en la GPU que en la CPU a 800 × 600 píxeles, y unas 40 veces menos a 1920 × 1080.
:::

## 8.1 Rendimiento del módulo 1: CPU frente a GPU

Se calculó la misma imagen de Mandelbrot (vista inicial, 200 iteraciones máximas, radio de escape 16) de dos formas: con un bucle en JavaScript y con el *fragment shader* del módulo 1. Cada medición es el promedio de 10 corridas, después de una corrida de calentamiento; la tabla promedia tres de esas mediciones. La medición se hace con la página `docs/build/bench-mandelbrot.html`.

| Resolución | CPU (JS), ms | GPU (WebGL), ms | Aceleración |
|---|---|---|---|
| 800 × 600 | 37,9 | 1,5 | ≈ 25× |
| 1920 × 1080 | 128 | 3,2 | ≈ 40× |

: Tiempo de cálculo de Mandelbrot, CPU frente a GPU

*Equipo usado:* procesador AMD Ryzen 5 3600X (6 núcleos), 32 GB de RAM, tarjeta gráfica NVIDIA GeForce GTX 1650 (Direct3D 11 mediante ANGLE), navegador basado en Chromium 156, Windows 11. Medido el 25/11/2026.

La ventaja de la GPU crece con la resolución: al pasar de 480 000 a 2 073 600 píxeles (4,3 veces más), la CPU tarda 3,4 veces más, mientras que la GPU apenas duplica su tiempo, porque calcula miles de píxeles en paralelo. Por eso el módulo 1 puede hacer zoom y animar los colores en tiempo real, cosa que con JavaScript en la CPU no sería fluida.

## 8.2 Validación del box-counting

El módulo 5 genera por sí mismo figuras de dimensión conocida. La curva de Koch se dibuja con la regla `F → F+F−−F+F` del módulo 3 (6 generaciones) y el triángulo de Sierpinski con 9 niveles de subdivisión. Se midió cada figura en una imagen de 1 024 × 1 024 píxeles, con cajas de 8 a 64 píxeles, y se comparó la dimensión medida con la teórica.

| Figura | Teórica | Medida | Error (%) |
|---|---|---|---|
| Línea recta | 1,000 | 0,988 | 1,2 |
| Curva de Koch | 1,262 | 1,264 | 0,2 |
| Triángulo de Sierpinski | 1,585 | 1,535 | 3,2 |
| Cuadrado relleno | 2,000 | 1,936 | 3,2 |

: Dimensión medida con box-counting frente a la teórica

El coeficiente $R^2$ del ajuste fue mayor que 0,999 en las cuatro figuras. Los errores del triángulo y del cuadrado vienen de que, con cajas grandes, la figura ocupa pocas cajas y el conteo depende de la posición de la malla. Con otro rango de escalas el resultado cambia: con cajas de 4 a 128 píxeles la curva de Koch da 1,260 y el cuadrado 1,892, de modo que el rango elegido afecta a la medición y debe indicarse siempre.

## 8.3 Limitaciones de las mediciones

Los tiempos dependen del equipo, del navegador y de la tarjeta gráfica, por lo que se indican las características de la máquina usada. Los tiempos de la GPU varían entre corridas (de 1,4 a 1,7 ms a 800 × 600, y de 2,5 a 3,7 ms a 1920 × 1080), porque incluyen la espera de sincronización con la tarjeta. La CPU calcula con números de 64 bits y la GPU con 32 bits, de modo que la comparación mide velocidad, no exactitud.
