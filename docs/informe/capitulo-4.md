# Capítulo 4. L-systems

> **Estado:** ajustado al módulo 3 implementado. Base de Valeria Flores (árbol con ramas por nivel e irregularidad en Canvas 2D), rediseñada con el estilo de los módulos 1 y 4 y ampliada con más ejemplos, reglas estocásticas, animación de crecimiento y viento.

## 4.1 Descripción del algoritmo

Un **L-system** (sistema de Lindenmayer) es un sistema de reescritura de cadenas. Lindenmayer (1968) lo propuso para describir el desarrollo de organismos filamentosos, donde todas las células se dividen en paralelo. Se compone de:

- Un **alfabeto** de símbolos.
- Un **axioma**, la cadena inicial.
- Un conjunto de **reglas de producción**, que reemplazan cada símbolo por una cadena.

En cada **generación**, las reglas se aplican a **todos** los símbolos a la vez (reescritura paralela). Los símbolos sin regla se copian igual. La cadena resultante se interpreta como instrucciones de dibujo para una **tortuga gráfica**, que tiene una posición y una dirección:

| Símbolo | Acción |
|---|---|
| `F`, `G`, `A`, `B` | Avanzar un paso dibujando una línea |
| `f` | Avanzar un paso sin dibujar |
| `+` / `−` | Girar a la izquierda / derecha el ángulo fijado |
| `\|` | Dar media vuelta |
| `[` | Guardar posición y dirección (apilar) |
| `]` | Recuperar posición y dirección (desapilar) |
| Otras letras (`X`, `Y`) | No dibujan; solo sirven para reescribirse |

### Ejemplo de reescritura

Con axioma `F` y regla `F → F+F−−F+F` (curva de Koch):

- Generación 0: `F` (1 segmento)
- Generación 1: `F+F−−F+F` (4 segmentos)
- Generación 2: cada `F` vuelve a cambiarse por `F+F−−F+F` (16 segmentos)

Cada generación multiplica por 4 el número de segmentos y divide su largo entre 3. Por eso la dimensión de la curva límite es `ln 4 / ln 3 ≈ 1,262`.

### L-systems estocásticos

En un L-system **estocástico**, un símbolo puede tener varias producciones, cada una con un peso. Al reescribir, cada aparición del símbolo elige una producción al azar según esos pesos. Así, las mismas reglas producen plantas distintas de una misma «especie». Para que el resultado se pueda reproducir, el azar sale de un generador pseudoaleatorio con **semilla**.

### En la aplicación

El módulo 3 implementa el algoritmo en cuatro etapas:

1. **Lectura de reglas.** Cada línea tiene la forma `símbolo=producción`. Para una regla estocástica se agrega un peso entre paréntesis, por ejemplo `X(0.34)=F[+X][-X]FX`. Si un símbolo tiene varias reglas sin peso, todas tienen la misma probabilidad.
2. **Reescritura paralela** durante el número de generaciones elegido, con un límite de 1 500 000 símbolos para no bloquear el navegador.
3. **Compilación** de la cadena a una lista compacta de instrucciones de tortuga. En esta etapa se validan los corchetes y se limita el dibujo a 400 000 segmentos.
4. **Interpretación** de la tortuga y **dibujo en Canvas 2D**. Los segmentos se agrupan por color y grosor para trazarlos con pocas llamadas.

Ejemplos incluidos:

| Ejemplo | Axioma | Reglas | Ángulo | Dimensión teórica |
|---|---|---|---|---|
| Curva de Koch | `F` | `F → F+F−−F+F` | 60° | ln 4 / ln 3 ≈ 1,262 |
| Copo de nieve de Koch | `F−−F−−F` | `F → F+F−−F+F` | 60° | ln 4 / ln 3 ≈ 1,262 |
| Triángulo de Sierpinski | `A` | `A → B−A−B`, `B → A+B+A` | 60° | ln 3 / ln 2 ≈ 1,585 |
| Curva del dragón | `FX` | `X → X+YF+`, `Y → −FX−Y` | 90° | 2 (llena una región) |
| Planta ramificada | `F` | `F → FF+[+F−F−F]−[−F+F+F]` | 22,5° | — |
| Árbol en un paisaje | `X` | `X → F[−X][X][+X]FX`, `F → FF` | 24° | — |
| Bosque estocástico | `X` | tres reglas para `X` (pesos 0,34 / 0,33 / 0,33) y `F → FF` | 25° | — |

En el árbol, el control **Ramas por nivel** (de 2 a 6) genera automáticamente la regla de `X` con ese número de corchetes. La **irregularidad** desvía un poco cada giro y cada tramo, con valores pseudoaleatorios fijados por la semilla. El grosor de las ramas, las hojas, el **viento** y el paisaje al atardecer son añadidos gráficos: no forman parte del L-system ni simulan el crecimiento biológico real.

Además, la aplicación permite:

- **Editar** el axioma y las reglas y ver el resultado de inmediato, con avisos si hay corchetes sin cerrar o si el dibujo supera los límites.
- **Ver crecer** el dibujo: la tortuga traza los segmentos en el mismo orden en que lee la cadena.
- Consultar la **cadena de cada generación** y las estadísticas (símbolos, segmentos, hojas y dimensión teórica).
- Acercar y mover el dibujo con el ratón, con gestos táctiles o con el teclado, y exportarlo a PNG.

## 4.2 Fortalezas

- **Descripción muy compacta.** Una o dos reglas producen estructuras ramificadas complejas.
- **Edición intuitiva.** Cambiar una regla, el axioma o el ángulo da formas nuevas, como el paso de la curva de Koch al copo de nieve con solo cambiar el axioma.
- **Adecuado para plantas.** La pila `[` `]` modela de manera natural la ramificación.
- **Extensible.** Admite variantes con probabilidades (implementadas en el módulo), parámetros o influencia del entorno.
- **Reproducible.** Con la semilla, un mismo bosque estocástico se puede regenerar exactamente.

## 4.3 Debilidades

- **Crecimiento exponencial.** La longitud de la cadena crece con cada generación. En el módulo, la planta pasa de 4 096 segmentos en la generación 4 a 32 768 en la 5, por lo que cada ejemplo limita el número de generaciones.
- **Aspecto rígido.** Las versiones determinísticas producen plantas demasiado regulares. El módulo lo atenúa con irregularidad y reglas estocásticas, pero el resultado sigue siendo esquemático.
- **Poco control geométrico fino.** Ajustar una forma concreta requiere ensayo y error.
- **Reglas sin garantía.** Una regla arbitraria no asegura un resultado reconocible.
- **Solo describe la estructura.** El grosor, las hojas y el color deben añadirse por separado.

## 4.4 Caso práctico de aplicación

Los L-systems se usan para **generar vegetación procedural** en videojuegos, cine y simulaciones, donde interesa producir muchas plantas distintas a partir de reglas breves. El ejemplo **Bosque estocástico** lo muestra: con tres reglas para `X` y una semilla distinta por árbol se obtiene un bosque variado, y una misma semilla reproduce siempre el mismo bosque. Los ejemplos geométricos (Koch, Sierpinski y dragón) permiten comparar un fractal de contorno con otro de ramificación. El triángulo de Sierpinski, además, conecta con el módulo 2: dos métodos distintos, la reescritura de cadenas y los IFS, llegan al mismo conjunto límite.

## 4.5 Capturas y demostración

- Capturas: `docs/presentacion/capturas/modulo3-arbol.png`, `modulo3-bosque.png` y `modulo3-dragon.png`
- Demostración: `modulos/03-l-systems/index.html`
