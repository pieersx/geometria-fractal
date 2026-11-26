# Capítulo 8. Resultados experimentales

::: resumen
**Resumen del capítulo.** Se comprueba con mediciones propias que la aplicación calcula bien y rápido: se compara el tiempo de Mandelbrot en CPU y en GPU y se contrasta la dimensión que mide el box-counting con el valor teórico.
:::

## 8.1 Rendimiento del módulo 1: CPU frente a GPU

Se calculó la misma imagen de Mandelbrot (vista inicial, 200 iteraciones máximas) de dos formas: con un bucle en JavaScript y con el *fragment shader* del módulo 1. Se tomó el promedio de 10 corridas, después de una corrida de calentamiento. La medición se hace con la página `docs/build/bench-mandelbrot.html`.

| Resolución | CPU (JS), ms | GPU (WebGL), ms | Aceleración |
|---|---|---|---|
| 800 × 600 | por medir | por medir | por medir |
| 1920 × 1080 | por medir | por medir | por medir |

: Tiempo de cálculo de Mandelbrot, CPU frente a GPU

*Equipo usado:* por completar (procesador, tarjeta gráfica, navegador y versión).

## 8.2 Validación del box-counting

Se generaron la curva de Koch (módulo 3) y el triángulo de Sierpinski (módulo 2), se cargaron en el módulo 5 y se comparó la dimensión medida con la teórica.

| Figura | Teórica | Medida | Error (%) |
|---|---|---|---|
| Curva de Koch | 1,262 | por medir | por medir |
| Triángulo de Sierpinski | 1,585 | por medir | por medir |

: Dimensión medida con box-counting frente a la teórica

## 8.3 Limitaciones de las mediciones

Los tiempos dependen del equipo, del navegador y de la tarjeta gráfica, por lo que se indican las características de la máquina usada. La CPU calcula con números de 64 bits y la GPU con 32 bits, de modo que la comparación mide velocidad, no exactitud.
