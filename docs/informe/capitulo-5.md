# Capítulo 5. Terreno fractal (fBm / diamond-square)

> **Estado:** borrador. El módulo 4 está pendiente; el texto describe lo que se planea implementar. **Su responsable debe ajustarlo al terminar y precisar cuál de los dos métodos implementa.**

## 5.1 Descripción del algoritmo

Un terreno natural presenta relieve a muchas escalas: cordilleras, colinas, rocas. Un **terreno fractal** reproduce esa propiedad combinando variaciones de altura en distintas escalas. Existen dos familias principales:

### Movimiento browniano fraccionario (fBm)

Se suman varias capas (octavas) de ruido suave. En cada octava la **frecuencia** se multiplica por un factor (la lacunaridad, normalmente 2) y la **amplitud** se reduce por otro factor (la persistencia, normalmente 0,5). El ruido de base suele ser un ruido de gradiente como el propuesto por Perlin (1985). La **rugosidad** del terreno se controla con el exponente de Hurst *H*, entre 0 y 1: valores bajos dan relieve áspero y valores altos, relieve suave. La dimensión fractal de la superficie resultante es aproximadamente `D = 3 − H`.

### Subdivisión con desplazamiento del punto medio (diamond-square)

Parte de una cuadrícula cuadrada con las cuatro esquinas fijadas y repite dos pasos: asignar al centro de cada cuadrado el promedio de sus esquinas más un desplazamiento aleatorio (paso *diamond*), y asignar a los puntos medios de los bordes el promedio de sus vecinos más otro desplazamiento (paso *square*). La amplitud del desplazamiento se reduce en cada ronda. Este enfoque de subdivisión estocástica corresponde a la línea de trabajo de Fournier et al. (1982).

### En la aplicación

Se mostrará el terreno en 3D con control de rugosidad, semilla aleatoria, número de octavas o ronda de subdivisión, y coloreado por altura.

## 5.2 Fortalezas

- **Aspecto natural convincente** con pocos parámetros.
- **Control de la rugosidad** mediante un único parámetro (*H* o la persistencia).
- **Eficiencia.** El diamond-square calcula una malla de lado 2ⁿ+1 en tiempo lineal respecto al número de puntos; el fBm se evalúa por punto y se puede paralelizar.
- **Reproducibilidad** al fijar la semilla del generador aleatorio.

## 5.3 Debilidades

- **Falta de realismo geológico.** No modelan erosión ni procesos físicos, por lo que los terrenos resultan homogéneos.
- **Artefactos.** El diamond-square puede dejar marcas en forma de cuadrícula; el fBm con ruido de gradiente puede mostrar direcciones preferentes.
- **Restricciones de tamaño.** El diamond-square exige mallas de lado 2ⁿ+1.
- **Control local limitado.** Es difícil colocar a propósito un valle o una cima concretos.

## 5.4 Caso práctico de aplicación

Los terrenos fractales son habituales en **videojuegos, simulación y cine** para generar paisajes sin modelarlos a mano. El ruido de gradiente de Perlin (1985) nació precisamente como herramienta de síntesis de texturas en imágenes por computadora. En la aplicación, ajustar la rugosidad permite pasar de llanuras suaves a cordilleras abruptas.

## 5.5 Capturas y demostración

- Captura: **[pendiente — módulo 4]**
- Demostración: `modulos/04-terreno-fractal/index.html`
