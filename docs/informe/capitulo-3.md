# Capítulo 3. Sistemas de funciones iteradas y juego del caos

::: resumen
**Resumen del capítulo.** Un IFS dibuja un fractal aplicando al azar transformaciones afines contractivas (juego del caos). Se ilustra con el triángulo de Sierpinski y el helecho de Barnsley.
:::

> **Estado:** borrador. El módulo 2 está pendiente; el texto describe lo que se planea implementar. **Su responsable debe ajustarlo al terminar.**

## 3.1 Descripción del algoritmo

Un **sistema de funciones iteradas (IFS)** es un conjunto finito de transformaciones afines contractivas `f1, …, fk`. Hutchinson (1981) demostró que existe un único conjunto compacto no vacío invariante bajo la unión de todas ellas, llamado **atractor**, y que es autosimilar. Barnsley y Demko (1985) desarrollaron este marco como método de construcción de fractales.

Cada transformación afín en el plano tiene la forma:

$$\begin{aligned} x' &= a\,x + b\,y + e \\ y' &= c\,x + d\,y + f \end{aligned}$$

### Juego del caos

El atractor se dibuja con un algoritmo probabilístico:

1. Elegir un punto inicial cualquiera.
2. Elegir al azar una transformación `fi`, con probabilidad `pi`.
3. Aplicar `fi` al punto y dibujar el resultado.
4. Repetir miles de veces, descartando los primeros puntos.

Los puntos se aproximan al atractor y lo recubren de forma progresiva.

### Ejemplos que se implementarán

- **Triángulo de Sierpinski.** Tres transformaciones que llevan el punto a la mitad de la distancia hacia cada vértice. Dimensión de similitud $\ln 3 / \ln 2 \approx 1{,}585$.
- **Helecho de Barnsley.** Cuatro transformaciones afines con probabilidades distintas (aproximadamente 1 %, 85 %, 7 % y 7 %), que modelan el tallo, las hojas sucesivas y las dos hojas laterales.

Los controles previstos son: selección del fractal, número de puntos, velocidad de dibujo, reinicio y exportación a PNG.

## 3.2 Fortalezas

- **Descripción compacta.** Pocos coeficientes definen una forma muy compleja.
- **Implementación sencilla.** El bucle del juego del caos es corto y rápido.
- **Aspecto natural.** Permite modelar formas orgánicas como hojas y helechos.
- **Base matemática sólida.** La existencia y unicidad del atractor está demostrada (Hutchinson, 1981).

## 3.3 Debilidades

- **Convergencia estocástica.** Con pocos puntos la imagen es ruidosa; las zonas de baja probabilidad tardan en rellenarse.
- **Control indirecto.** Es difícil prever la forma resultante a partir de los coeficientes.
- **Resolución limitada.** La imagen depende del número de puntos y del tamaño del lienzo.
- **Problema inverso.** Hallar un IFS que reproduzca una forma dada es difícil.

## 3.4 Caso práctico de aplicación

Los IFS se han usado para **modelar vegetación y formas naturales** en gráficos por computadora y como base de algunos esquemas de **compresión fractal de imágenes**, que almacenan una imagen como las transformaciones que la regeneran. En la aplicación, el helecho de Barnsley sirve de ejemplo: ocho números por transformación bastan para dibujar una hoja reconocible.

## 3.5 Capturas y demostración

- Captura: **[pendiente — módulo 2]**

<div class="demo"><img src="img/qr-modulo-2.svg" alt="Código QR del módulo 2"><p><strong>Pruébalo en la aplicación.</strong><br>Escanea el código o abre la dirección:<br><span class="url">https://pieersx.github.io/geometria-fractal/modulos/02-ifs-chaos-game/</span></p></div>
