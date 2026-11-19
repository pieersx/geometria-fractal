# Descripción de la aplicación gráfica

> **Estado:** borrador. Solo el módulo 1 está implementado; los módulos 2 a 5 se describen según el diseño acordado.

## 1. Visión general

La aplicación es un conjunto de páginas web interactivas, escritas en **HTML y JavaScript**, que usan **WebGL** en los conjuntos de escape y en el terreno fractal, y que se ejecutan en el navegador sin instalar nada. Una portada (`index.html`) enlaza a cinco módulos independientes, uno por técnica estudiada en el informe.

## 2. Arquitectura

El diagrama `arquitectura-app.drawio` resume la estructura: la portada enlaza a los cinco módulos, y cada módulo es una página autocontenida con un panel de controles a la izquierda y un lienzo a pantalla completa. Cada módulo parte de una misma plantilla (`modulos/_plantilla`).

| Componente | Función |
|---|---|
| `index.html` | Portada con enlaces a los módulos |
| `modulos/01-conjuntos-escape` | Mandelbrot y Julia en WebGL (implementado) |
| `modulos/02-ifs-chaos-game` | Juego del caos: Sierpinski y helecho (pendiente) |
| `modulos/03-l-systems` | Curva de Koch y plantas (pendiente) |
| `modulos/04-terreno-fractal` | Terreno 3D con diamond-square en WebGL (implementado) |
| `modulos/05-dimension-fractal` | Box-counting sobre una imagen cargada (pendiente) |
| `modulos/_plantilla` | Base común: panel, lienzo, Reiniciar y Guardar PNG |

## 3. Decisiones de diseño

- **Módulos autocontenidos.** Cada `index.html` funciona por sí solo, lo que permite que cada integrante trabaje sin afectar a los demás y que la demostración se abra con doble clic.
- **Interfaz uniforme.** Panel de controles a la izquierda y lienzo grande, con botones comunes para reiniciar y exportar a PNG.
- **WebGL donde el cálculo es por píxel.** En el módulo 1 el cálculo se delega a la GPU mediante un *fragment shader*, lo que permite zoom y animación en tiempo real.
- **Sin dependencias externas obligatorias.** Si un módulo usa una biblioteca, debe cargarse con versión fija.

## 4. Requisitos y ejecución

- Navegador actual (Chrome, Firefox o Edge). Los módulos 1 y 4 requieren además soporte de WebGL.
- Abrir `index.html` o el módulo deseado. Opcionalmente, servir la carpeta con `python3 -m http.server 8000` y entrar a `http://localhost:8000`.

## 5. Interacción del módulo 1

Zoom con la rueda del ratón, desplazamiento arrastrando, selección entre Mandelbrot y Julia, ajuste de `c`, iteraciones máximas, paletas, animación de color, reinicio de vista y exportación a PNG. La aplicación muestra el zoom, el centro y los cuadros por segundo, y advierte cuando se alcanza el límite de precisión de 32 bits.

## 6. Limitaciones conocidas

- El zoom profundo del módulo 1 está limitado por la precisión `float32` de la GPU.
- Los módulos 2 a 5 aún no están implementados.
- La aplicación no se ha probado en todos los navegadores ni dispositivos móviles.
