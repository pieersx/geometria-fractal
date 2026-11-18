# Conclusión

> **Estado:** borrador. Completar con los resultados reales de los módulos 2 a 5 antes de entregar.

El trabajo permitió estudiar y representar en tiempo real cinco técnicas de geometría fractal. Se confirmó que **reglas muy simples pueden generar estructuras de gran complejidad**: una iteración cuadrática produce los conjuntos de Mandelbrot y Julia, un puñado de transformaciones afines dibuja un helecho, y unas pocas reglas de reescritura describen una planta ramificada.

Cada técnica tiene un perfil propio. Los conjuntos de escape aprovechan el paralelismo de la GPU pero chocan con los límites de precisión numérica. Los sistemas de funciones iteradas son compactos y tienen sólido respaldo matemático, aunque su convergencia es estocástica. Los L-systems modelan bien la ramificación, pero crecen exponencialmente con las generaciones. Los terrenos fractales dan paisajes convincentes con pocos parámetros, a costa de realismo geológico. La estimación de la dimensión fractal conecta la teoría con imágenes reales, aunque depende de la binarización y del rango de escalas.

Desde la computación visual, el proyecto mostró el valor de combinar fundamentos matemáticos con una implementación interactiva: la interfaz con controles en tiempo real permite comprender el efecto de cada parámetro mejor que una descripción escrita. El uso de módulos independientes y de una plantilla común facilitó el trabajo en equipo.

Como **trabajo futuro** se identifican: aumentar la precisión del zoom en los conjuntos de escape, añadir variantes estocásticas a los L-systems, incorporar erosión a los terrenos y validar el box-counting con formas de dimensión conocida.
