# Capítulo 6. Dimensión fractal y box-counting

::: resumen
**Resumen del capítulo.** El conteo de cajas estima la dimensión fractal de una imagen a partir de la pendiente de $\log N(\varepsilon)$ frente a $\log(1/\varepsilon)$. Se valida con la curva de Koch y el triángulo de Sierpinski.
:::

> **Estado:** borrador. El módulo 5 está pendiente; el texto describe lo que se planea implementar. **Su responsable debe ajustarlo al terminar.**

## 6.1 Descripción del algoritmo

La **dimensión fractal** cuantifica cuánto espacio ocupa una forma a distintas escalas. Mandelbrot (1967) usó esta idea para describir la rugosidad de las costas: cuanto más irregular es el contorno, mayor es su dimensión, entre 1 (una curva suave) y 2 (una curva que llena el plano).

El método de **conteo de cajas** (*box-counting*) la estima de forma empírica:

1. Convertir la imagen a blanco y negro (binarizar), de modo que la forma de interés quede como píxeles activos.
2. Cubrir la imagen con una malla de cajas cuadradas de lado ε.
3. Contar el número *N(ε)* de cajas que contienen al menos un píxel activo.
4. Repetir con varios valores de ε (por ejemplo, potencias de 2).
5. Representar $\log N(\varepsilon)$ frente a $\log(1/\varepsilon)$. La **pendiente** de la recta de mejor ajuste estima la dimensión:

$$N(\varepsilon) \propto \varepsilon^{-D} \quad\Longrightarrow\quad D \approx \text{pendiente de } \log N(\varepsilon) \text{ frente a } \log (1/\varepsilon)$$

Liebovitch y Toth (1989) describen un algoritmo rápido para este cálculo, que sirve de referencia para la implementación.

### En la aplicación

El usuario carga una imagen propia; la aplicación la binariza con un umbral ajustable, aplica el conteo de cajas, dibuja la gráfica log-log con la recta de ajuste y muestra el valor estimado de *D*.

### Validación

Para comprobar el módulo se pueden usar formas de dimensión conocida: una línea recta (*D* ≈ 1), un cuadrado relleno (*D* ≈ 2), la curva de Koch (≈ 1,262) y el triángulo de Sierpinski (≈ 1,585), generadas con los otros módulos.

## 6.2 Fortalezas

- **Aplicable a imágenes reales,** no solo a fractales matemáticos.
- **Simple de implementar** y de explicar.
- **Resultado numérico interpretable,** acompañado de una gráfica que permite juzgar la calidad del ajuste.

## 6.3 Debilidades

- **Sensible a la binarización.** El umbral elegido cambia la forma analizada y, con ella, el resultado.
- **Rango de escalas finito.** La imagen tiene resolución limitada, por lo que el comportamiento de ley de potencias solo se cumple en un intervalo.
- **Dependencia de la posición de la malla** y de la elección de tamaños de caja.
- **Un objeto natural no es autosimilar infinitamente,** así que el valor es una estimación y no una propiedad exacta.

## 6.4 Caso práctico de aplicación

La dimensión fractal se emplea para **caracterizar formas naturales**: líneas de costa, redes de ramificación, texturas de tejidos o de superficies. El caso clásico es la medición de costas (Mandelbrot, 1967). En la aplicación se podrá cargar, por ejemplo, la silueta de un mapa o de una hoja y comparar su dimensión con la de una figura geométrica simple.

## 6.5 Capturas y demostración

- Captura: **[pendiente — módulo 5]**

<div class="demo"><img src="img/qr-modulo-5.svg" alt="Código QR del módulo 5"><p><strong>Pruébalo en la aplicación.</strong><br>Escanea el código o abre la dirección:<br><span class="url">https://pieersx.github.io/geometria-fractal/modulos/05-dimension-fractal/</span></p></div>
