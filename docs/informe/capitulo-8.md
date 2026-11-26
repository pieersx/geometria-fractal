# Capítulo 8. Resultados experimentales

::: resumen
**Resumen del capítulo.** Se comprueba con mediciones propias que la aplicación calcula rápido: el mismo Mandelbrot tarda unas 25 veces menos en la GPU que en la CPU a 800 × 600 píxeles, y unas 40 veces menos a 1920 × 1080. También se midió el cálculo de los módulos 2 a 5, que en la CPU tarda de menos de 1 ms a medio segundo según el tamaño del problema.
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

## 8.3 Tiempos de cálculo de los módulos 2 a 5

Además del módulo 1, se midió cuánto tarda el cálculo de cada uno de los otros cuatro módulos, con los mismos parámetros que usa la aplicación. Los cuatro se calculan en la CPU con JavaScript; la GPU solo interviene al dibujar el terreno (módulo 4) y la vista 3D de los L-systems. Cada tiempo es el promedio de 3 a 30 corridas (las más largas, menos) con `performance.now()`, después de corridas de calentamiento.

*Equipo usado en esta sección:* procesador AMD Ryzen 5 5500, 32 GB de RAM, Linux, navegador basado en Chromium 156. Medido el 26/11/2026. Es una máquina distinta de la del apartado 8.1, de modo que los tiempos de ambos apartados no se comparan entre sí.

**Módulo 2: juego del caos.** El tiempo incluye calcular los puntos y pintarlos en un lienzo de 1 200 × 800 píxeles.

| Fractal | 100 000 puntos, ms | 1 000 000 puntos, ms | 10 000 000 puntos, ms |
|---|---|---|---|
| Triángulo de Sierpinski (r = 0,5) | 22 | 98 | 551 |
| Helecho de Barnsley | 22 | 100 | 548 |

: Tiempo del juego del caos según el número de puntos

El tiempo crece de forma casi lineal con el número de puntos, a unos 18 millones de puntos por segundo, y el helecho (cuatro transformaciones afines) no cuesta más que el triángulo. Por eso la aplicación dibuja por lotes: con 10 millones de puntos la imagen se completa en medio segundo.

**Módulo 3: L-systems.** El tiempo corresponde a reescribir la cadena, compilarla y recorrerla con la tortuga; no incluye el dibujo en pantalla.

| Ejemplo | Generaciones | Símbolos de la cadena | Segmentos | Tiempo, ms |
|---|---|---|---|---|
| Curva de Koch | 4 | 596 | 256 | 0,2 |
| Curva de Koch | 6 | 9 556 | 4 096 | 1,6 |
| Triángulo de Sierpinski | 6 | 1 457 | 729 | 0,3 |
| Triángulo de Sierpinski | 8 | 13 121 | 6 561 | 1,4 |
| Curva del dragón | 12 | 16 382 | 4 096 | 1,2 |
| Curva del dragón | 14 | 65 534 | 16 384 | 4,5 |
| Planta ramificada | 5 | 88 940 | 32 768 | 4,9 |
| Árbol en un paisaje | 6 | 19 048 | 4 032 | 0,9 |
| Bosque estocástico | 5 | 7 354 | 2 110 | 0,5 |

: Tiempo de reescritura y recorrido de la tortuga en los L-systems

Los segmentos se multiplican por 4 en cada generación de la curva de Koch (256 segmentos en la generación 4 y 4 096 en la 6), por 3 en Sierpinski y por 2 en el dragón, y el tiempo sigue al tamaño de la cadena, a unos 15 millones de símbolos por segundo. La cadena crece de forma exponencial con las generaciones, de modo que el límite de la aplicación (1 500 000 símbolos) protege al navegador antes de que el cálculo se vuelva lento.

**Módulo 4: terreno fractal.** El tiempo es el de generar la malla de alturas con diamond-square; no incluye calcular normales, subir los datos a la GPU ni dibujar.

| Nivel de detalle | Malla | Puntos | Tiempo, ms |
|---|---|---|---|
| 5 | 33 × 33 | 1 089 | 0,02 |
| 6 | 65 × 65 | 4 225 | 0,07 |
| 7 | 129 × 129 | 16 641 | 0,21 |
| 8 (valor por omisión) | 257 × 257 | 66 049 | 0,84 |
| 9 (máximo) | 513 × 513 | 263 169 | 4,64 |

: Tiempo de diamond-square según el nivel de detalle (rugosidad 0,59)

Cada nivel multiplica por 4 los puntos de la malla y por 3 a 5,5 el tiempo. En el nivel por omisión, el terreno se genera en menos de 1 ms, mucho menos que los 16,7 ms de un cuadro a 60 imágenes por segundo, por lo que el control de rugosidad responde sin retraso.

**Módulo 5: box-counting.** Se midió sobre la imagen de trabajo de 1 024 × 1 024 píxeles.

| Figura | Generar la figura, ms | Analizar, ms | Dimensión medida |
|---|---|---|---|
| Línea recta | 3,4 | 2,9 | 0,988 |
| Curva de Koch | 5,5 | 2,7 | 1,264 |
| Triángulo de Sierpinski | 543 | 2,9 | 1,535 |
| Cuadrado relleno | 3,4 | 2,6 | 1,936 |

: Tiempo del box-counting (binarizar, contar cajas y ajustar la recta)

El análisis dura unos 3 ms sea cual sea la figura, porque siempre recorre la misma imagen, así que el valor de la dimensión se actualiza en vivo al mover el umbral. Lo más lento es generar el triángulo de Sierpinski con 9 niveles de subdivisión. Las dimensiones de esta corrida coinciden con las de la sección 8.2, lo que confirma que la medición reproduce el cálculo de la aplicación.

## 8.4 Limitaciones de las mediciones

Los tiempos dependen del equipo, del navegador y de la tarjeta gráfica, por lo que se indican las características de la máquina usada. Los tiempos de la GPU varían entre corridas (de 1,4 a 1,7 ms a 800 × 600, y de 2,5 a 3,7 ms a 1920 × 1080), porque incluyen la espera de sincronización con la tarjeta. La CPU calcula con números de 64 bits y la GPU con 32 bits, de modo que la comparación mide velocidad, no exactitud.

Las mediciones del apartado 8.3 corresponden solo al cálculo en la CPU. El entorno de medición no tenía WebGL, de modo que no se midió el tiempo de dibujo del terreno ni de la vista 3D de los L-systems. Los tiempos por debajo de 1 ms (niveles 5 a 7 del terreno y los L-systems pequeños) están cerca de la resolución del reloj del navegador y deben leerse como órdenes de magnitud.
