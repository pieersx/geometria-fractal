# Capítulo 2. Conjuntos de escape: Mandelbrot y Julia

> **Estado:** borrador. El módulo 1 ya cuenta con prototipo; el texto describe su comportamiento actual.

## 2.1 Descripción del algoritmo

Los conjuntos de escape se definen iterando la función cuadrática compleja:

```
z(n+1) = z(n)² + c
```

- **Conjunto de Mandelbrot.** Se parte de `z0 = 0` y se prueba cada valor de `c` del plano complejo. Pertenece al conjunto el `c` para el cual la sucesión permanece acotada.
- **Conjunto de Julia.** Se fija un `c` y se prueba cada punto inicial `z0` del plano. Cada valor de `c` genera un conjunto distinto.

En la práctica no se puede iterar indefinidamente. Se fija un número máximo de iteraciones y se considera que un punto **escapa** cuando |z| supera un radio de escape: si |z| > 2, la sucesión diverge con seguridad. Los puntos que no escapan tras el máximo de iteraciones se pintan como pertenecientes al conjunto (negro en la aplicación). Los demás se colorean según la rapidez con que escapan.

### Coloreado suave

Colorear por el número entero de iteraciones produce bandas visibles. El módulo 1 aplica un coloreado suave que usa un valor continuo de iteración:

```
mu = n + 1 − log2( log2 |z| )
```

Para que la aproximación sea precisa se usa un radio de escape grande (en el prototipo, |z|² > 256). El valor `mu` se pasa por una escala logarítmica y luego por una paleta cosenoidal.

### Implementación en la aplicación

El cálculo se hace en el *fragment shader* de WebGL: cada píxel evalúa su propia iteración en la GPU, lo que permite zoom y animación fluidos. Los controles son:

- Selector Mandelbrot / Julia, con deslizadores para la parte real e imaginaria de `c` y una lista de conjuntos famosos.
- Iteraciones máximas, de 30 a 1500.
- Cinco paletas de color y animación del color.
- Zoom y desplazamiento con el ratón, reinicio de la vista y exportación a PNG.

## 2.2 Fortalezas

- **Paralelismo natural.** Cada píxel es independiente, por lo que el cálculo se ajusta bien a la GPU.
- **Detalle a cualquier escala.** El borde del conjunto muestra estructura nueva al ampliar.
- **Pocos parámetros, mucha variedad.** Cambiar `c` o el número de iteraciones modifica radicalmente la imagen.
- **Implementación breve.** El núcleo del algoritmo cabe en pocas líneas.

## 2.3 Debilidades

- **Precisión numérica.** El prototipo usa números de coma flotante de 32 bits (`float32`), por lo que el zoom profundo degrada la imagen y el módulo muestra una advertencia al llegar al límite. Superarlo exige aritmética de mayor precisión, con coste elevado.
- **Coste creciente con el zoom.** Cerca del borde hacen falta más iteraciones para distinguir puntos.
- **Decisión de pertenencia aproximada.** Un punto que no escapa en *N* iteraciones podría escapar más tarde.
- **Dependencia de WebGL.** Navegadores o equipos sin soporte no pueden ejecutar el módulo.

## 2.4 Caso práctico de aplicación

Los conjuntos de escape se emplean en **generación de texturas y arte procedural**, y como banco de pruebas de rendimiento de GPU, ya que son una carga computacional controlable. Un uso docente típico es explorar cómo la dinámica de una función simple, como `z² + c`, produce comportamientos regulares y caóticos. Un ejemplo concreto en la aplicación es el conjunto de Julia «Dragón» (`c = −0,8 + 0,156i`), que ilustra cómo un cambio pequeño de `c` altera por completo la forma.

## 2.5 Capturas y demostración

- Mandelbrot: `../presentacion/capturas/modulo1-mandelbrot.png`
- Mandelbrot con zoom: `../presentacion/capturas/modulo1-mandelbrot-zoom.png`
- Julia: `../presentacion/capturas/modulo1-julia.png`
- Demostración: `modulos/01-conjuntos-escape/index.html`

## 2.6 Referencias del capítulo

La autosimilitud estadística y la dimensión fraccionaria que subyacen a estos conjuntos se tratan en Mandelbrot (1967). La definición matemática de conjuntos autosimilares por iteración se formaliza en Hutchinson (1981).
