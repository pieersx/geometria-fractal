# Capítulo 1. Introducción a la geometría fractal

> **Estado:** borrador.

## 1.1 ¿Qué es un fractal?

La geometría euclidiana describe bien las formas regulares (rectas, círculos, poliedros), pero resulta insuficiente para modelar costas, nubes, montañas o ramificaciones vegetales. La geometría fractal ofrece un lenguaje matemático para esas formas irregulares. Aunque no existe una definición única y completa, un fractal se reconoce por dos rasgos: **autosimilitud** y **dimensión fraccionaria**.

### Autosimilitud

Un objeto es autosimilar cuando sus partes se parecen al todo. La similitud puede ser **exacta**, como en el triángulo de Sierpinski, donde cada subtriángulo es una copia reducida del conjunto, o **estadística**, como en una línea costera, donde los detalles a distintas escalas comparten las mismas propiedades estadísticas sin ser idénticos (Mandelbrot, 1967).

### Dimensión fraccionaria

Un segmento tiene dimensión 1, un cuadrado dimensión 2 y un cubo dimensión 3. En un objeto autosimilar formado por *N* copias de sí mismo reducidas por un factor *r*, la dimensión de similitud es:

```
D = ln(N) / ln(1/r)
```

El triángulo de Sierpinski está formado por 3 copias reducidas a la mitad, por lo que `D = ln 3 / ln 2 ≈ 1,585`. La curva de Koch usa 4 copias a escala 1/3, con `D = ln 4 / ln 3 ≈ 1,262`. Que *D* no sea un entero indica que el objeto llena el plano más que una curva, pero menos que una superficie. Mandelbrot (1967) mostró que la longitud medida de una costa depende de la escala de medición y que esa dependencia se resume en una dimensión fraccionaria.

## 1.2 Breve recorrido histórico

- **1967.** Mandelbrot publica en *Science* el artículo sobre la longitud de la costa de Gran Bretaña, que relaciona autosimilitud estadística y dimensión fraccionaria.
- **1968.** Lindenmayer propone un formalismo de reescritura de cadenas para modelar el desarrollo de organismos filamentosos (Lindenmayer, 1968), base de los L-systems.
- **1981.** Hutchinson formaliza los conjuntos autosimilares como puntos fijos de operadores de contracciones (Hutchinson, 1981).
- **1982.** Fournier, Fussell y Carpenter presentan métodos de subdivisión estocástica para sintetizar terrenos y otras formas naturales (Fournier et al., 1982).
- **1985.** Barnsley y Demko desarrollan los sistemas de funciones iteradas como método de construcción global de fractales (Barnsley & Demko, 1985).

## 1.3 Fractales en computación visual

Los fractales son atractivos en gráficos por computadora porque **generan gran complejidad visual a partir de reglas muy cortas**. Un puñado de parámetros produce imágenes de detalle prácticamente ilimitado, lo que los hace útiles para texturas, vegetación, terrenos y compresión de imágenes. Además, la mayoría de los algoritmos es paralelizable, de modo que una GPU puede evaluarlos píxel a píxel en tiempo real, como se hace en este proyecto.

## 1.4 Técnicas estudiadas

| Capítulo | Técnica | Idea central |
|---|---|---|
| 2 | Conjuntos de escape (Mandelbrot, Julia) | Iterar una función compleja y observar si el valor diverge |
| 3 | Sistemas de funciones iteradas (IFS) y juego del caos | Aplicar transformaciones afines contractivas de forma aleatoria |
| 4 | L-systems | Reescribir cadenas y reinterpretarlas como dibujo |
| 5 | Terreno fractal | Sumar o subdividir ruido a varias escalas |
| 6 | Dimensión fractal | Estimar *D* contando cajas que cubren una imagen |
