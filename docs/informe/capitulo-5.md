# Capítulo 5. Terreno fractal (diamond-square)

> **Estado:** ajustado al módulo 4 implementado (Keyla Sihuacollo). El módulo usa **diamond-square**; el fBm se describe solo como método alternativo de referencia.

## 5.1 Descripción del algoritmo

Un terreno natural presenta relieve a muchas escalas: cordilleras, colinas, rocas. Un **terreno fractal** reproduce esa propiedad combinando variaciones de altura en distintas escalas. Existen dos familias principales:

### Movimiento browniano fraccionario (fBm)

Se suman varias capas (octavas) de ruido suave. En cada octava la **frecuencia** se multiplica por un factor (la lacunaridad, normalmente 2) y la **amplitud** se reduce por otro factor (la persistencia, normalmente 0,5). El ruido de base suele ser un ruido de gradiente como el propuesto por Perlin (1985). La **rugosidad** del terreno se controla con el exponente de Hurst *H*, entre 0 y 1: valores bajos dan relieve áspero y valores altos, relieve suave. La dimensión fractal de la superficie resultante es aproximadamente `D = 3 − H`.

### Subdivisión con desplazamiento del punto medio (diamond-square)

Parte de una cuadrícula cuadrada con las cuatro esquinas fijadas y repite dos pasos: asignar al centro de cada cuadrado el promedio de sus esquinas más un desplazamiento aleatorio (paso *diamond*), y asignar a los puntos medios de los bordes el promedio de sus vecinos más otro desplazamiento (paso *square*). La amplitud del desplazamiento se reduce en cada ronda. Este enfoque de subdivisión estocástica corresponde a la línea de trabajo de Fournier et al. (1982).

### En la aplicación

El módulo implementa **diamond-square** sobre una cuadrícula de lado 2ⁿ+1, con n entre 3 y 6 (de 9 × 9 a 65 × 65 puntos). Las cuatro esquinas parten de valores aleatorios pequeños y la amplitud inicial del desplazamiento es 0,78. Al terminar cada ronda, la amplitud se multiplica por la **rugosidad** *r* (entre 0,15 y 0,90; 0,59 por defecto). En los bordes, los puntos del paso *square* promedian solo los vecinos que existen, sin envolver la malla.

Multiplicar la amplitud por *r* en cada ronda equivale a un exponente de Hurst *H* = −log₂ *r* (derivación propia a partir de la relación entre ambos parámetros). Con *r* = 0,59, *H* ≈ 0,76 y *D* ≈ 2,24. Esto es una estimación teórica; el módulo no mide la dimensión de la superficie.

Los desplazamientos salen de un generador pseudoaleatorio congruencial con **semilla** (0 a 4 294 967 295), así que una misma semilla reproduce el mismo terreno. El botón «Generar otro terreno» elige una semilla nueva.

La visualización usa **Canvas 2D**, no WebGL. La malla se proyecta con una rotación (giro y cabeceo) y se divide en triángulos que se ordenan por profundidad y se dibujan de atrás hacia delante (algoritmo del pintor). Cada triángulo se colorea según su **elevación**, con tres paletas (alpina, desierto, violeta), y se sombrea con una luz fija a partir de su pendiente.

Controles disponibles: paleta, rugosidad, altura del relieve (0,35× a 1,8×; solo reescala la altura, no regenera), nivel de detalle, semilla, malla visible, giro con ratón o flechas, zoom con rueda o teclas + y −, reinicio de vista y guardado en PNG.

## 5.2 Fortalezas

- **Aspecto natural convincente** con pocos parámetros.
- **Control de la rugosidad** mediante un único parámetro (*H* o la persistencia).
- **Eficiencia.** El diamond-square calcula una malla de lado 2ⁿ+1 en tiempo lineal respecto al número de puntos; el fBm se evalúa por punto y se puede paralelizar.
- **Reproducibilidad** al fijar la semilla del generador aleatorio.
- **Interactividad.** Con la malla máxima (65 × 65, unos 8 192 triángulos) la vista se redibuja al girar y hacer zoom; no se midieron tiempos en este informe.

## 5.3 Debilidades

- **Falta de realismo geológico.** No modelan erosión ni procesos físicos, por lo que los terrenos resultan homogéneos.
- **Artefactos.** El diamond-square puede dejar marcas en forma de cuadrícula; el fBm con ruido de gradiente puede mostrar direcciones preferentes.
- **Restricciones de tamaño.** El diamond-square exige mallas de lado 2ⁿ+1.
- **Control local limitado.** Es difícil colocar a propósito un valle o una cima concretos.
- **Resolución acotada en la aplicación.** El detalle máximo es 65 × 65 puntos y el algoritmo del pintor reordena todos los triángulos en cada cuadro, por lo que no escala bien a mallas mucho mayores.

## 5.4 Caso práctico de aplicación

Los terrenos fractales son habituales en **videojuegos, simulación y cine** para generar paisajes sin modelarlos a mano. El ruido de gradiente de Perlin (1985) nació precisamente como herramienta de síntesis de texturas en imágenes por computadora. En la aplicación, bajar la rugosidad produce llanuras suaves y subirla produce cordilleras abruptas.

## 5.5 Capturas y demostración

- Captura: **[pendiente: tomar con la semilla 4817 (valor por defecto) para que sea reproducible]**
- Demostración: `modulos/04-terreno-fractal/index.html`
