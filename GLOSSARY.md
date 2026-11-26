# Glosario

Términos que usamos con un solo significado en la aplicación y en el informe.

## L-systems

- **Axioma:** cadena inicial de un L-system, antes de aplicar cualquier regla.
- **Regla de producción:** sustitución de un símbolo por una cadena (`F=FF`).
- **Generación:** una aplicación de todas las reglas, a la vez, a toda la cadena. Es el término oficial; no usar «iteración» para los L-systems.
- **Paso:** avance de la tortuga en un símbolo de dibujo. No confundir con generación.
- **Tortuga gráfica:** intérprete que recorre la cadena y dibuja según cada símbolo.
- **Regla estocástica:** una de varias producciones de un mismo símbolo, elegida al azar según su peso.
- **Semilla:** número que fija el azar para que un resultado se pueda reproducir.
- **Tropismo:** inclinación de la dirección de la tortuga hacia un vector fijo después de cada paso; imita la gravedad o la luz.
- **Dimensión teórica:** dimensión fractal calculada a partir de la regla (por ejemplo, ln 4 / ln 3 en la curva de Koch), no medida sobre el dibujo.
- **Dimensión medida:** dimensión fractal estimada con box-counting sobre una imagen. Se compara con la dimensión teórica; no son lo mismo.

## IFS y juego del caos

- **IFS (sistema de funciones iteradas):** conjunto finito de transformaciones contractivas cuyo atractor es el fractal.
- **Atractor:** conjunto al que se aproximan los puntos al aplicar el IFS una y otra vez, sea cual sea el punto inicial.
- **Juego del caos:** algoritmo que dibuja el atractor eligiendo al azar una transformación en cada paso y aplicándola al punto actual.
- **Razón de contracción (r):** fracción de su posición anterior en la que queda el punto tras cada paso, medida desde el vértice elegido: x' = r·x + (1 − r)·v. El punto recorre 1 − r del camino hacia el vértice.
- **Solape:** situación en que las copias reducidas del fractal se superponen porque r es demasiado grande; la dimensión de semejanza deja de valer.
- **Dimensión de semejanza:** ln n / ln(1/r), con n copias reducidas por la razón r y sin solape. Es el caso de la dimensión teórica en fractales autosemejantes.

## Box-counting

- **Box-counting (conteo de cajas):** método que estima la dimensión fractal contando cuántas cajas de lado s tocan la figura, para varios valores de s.
- **Caja:** cuadrado de lado s de la malla que cubre la imagen. Una caja está ocupada si toca al menos un píxel de la figura.
- **Binarización:** conversión de la imagen a píxeles de figura y de fondo mediante un umbral.
- **Umbral de Otsu:** umbral elegido automáticamente para separar figura y fondo con la mayor diferencia entre ambos grupos.
- **Rango de escalas:** intervalo de tamaños de caja usado en el ajuste. Cambiarlo cambia el resultado, por lo que siempre se indica.
