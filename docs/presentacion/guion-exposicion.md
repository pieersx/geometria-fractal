# Guion de la exposición (20 minutos)

**Presentación:** [geometria-fractal-presentacion.pdf](geometria-fractal-presentacion.pdf) · 18 diapositivas · **Fecha: 02/12/2026**

Regla para todos: **explicar sin leer**. Cada idea sigue el mismo orden: *idea en una frase → ejemplo con números pequeños → qué se ve en la app*.

## Reparto de tiempo

| Diap. | Contenido | Quién | Tiempo |
|---|---|---|---|
| 1–2 | Portada y agenda | Camila | 1:00 |
| 3 | ¿Qué es un fractal? | Camila | 1:30 |
| 4 | Cinco técnicas, una aplicación | Camila | 1:00 |
| 5–7 | Módulo 1: Mandelbrot, Julia y cómo se forman | Pieers | 3:30 |
| 8 | Módulo 2: IFS y juego del caos | Emily | 2:00 |
| 9 | Módulo 3: L-systems | Valeria | 2:00 |
| 10–11 | Módulo 4: terreno fractal | Keyla | 2:30 |
| 12 | Módulo 5: box-counting | Rodrigo | 2:00 |
| 13 | Hilo conductor: la curva de Koch | Rodrigo | 1:00 |
| 14 | Demostración en vivo | Pieers | 1:30 |
| 15–16 | Fortalezas, debilidades y conclusiones | Camila | 1:30 |
| 17–18 | Referencias y preguntas | Todos | resto |
| | **Total** | | **≈ 19:30** |

📌 Ensayar el 01/12 **con cronómetro**. Si una persona pasa de su tiempo, se recorta la diapositiva 13 o la 15, nunca la demo.

---

## Diapositivas 3–4 · Camila

**Mensaje:** un fractal es una forma que se repite a escalas distintas y que sale de reglas muy cortas.

- **Autosimilitud:** una parte se parece al todo (una rama, un helecho, la costa).
- **Dimensión fraccionaria:** una curva muy irregular ocupa más que una línea (D = 1) pero menos que un plano (D = 2).
- Mandelbrot (1967) mostró que la longitud de una costa depende de la regla con que se mide.

## Diapositivas 5–7 · Pieers (módulo 1)

**Mensaje:** se repite una fórmula sencilla y se pinta cada punto según si «escapa» o no.

- **Fórmula:** $z \to z^2 + c$. En Mandelbrot se parte de $z = 0$ y se varía $c$. En Julia se fija $c$ y se varía el punto inicial.
- **Ejemplo con números:** con $c = 1$: $0 \to 1 \to 2 \to 5 \to 26$ crece sin parar, así que **escapa**. Con $c = -1$: $0 \to -1 \to 0 \to -1$ se queda acotado, así que **pertenece al conjunto**.
- **Por qué |z| > 2:** si $|z|$ supera 2 (con $|c| \le 2$), la sucesión diverge con seguridad. Es el radio de escape.
- **En la app:** cada píxel se calcula en paralelo en la GPU (WebGL). Se puede hacer zoom y cambiar *c* en vivo (diapositiva 6).
- **Cómo se forma (diapositiva 7):** con «Construir desde cero» se parte de todo negro y cada iteración añade una capa; con «Órbita de un punto» se ve la sucesión *z*₀, *z*₁, *z*₂… salir de la circunferencia |*z*| = 2.
- **Límite que mostramos:** con `float32` el zoom profundo se pixela y la app avisa (Figura 2.7 del informe).

## Diapositiva 8 · Emily (módulo 2) — *ajustar al terminar el módulo*

**Mensaje:** un punto que salta al azar acaba dibujando una figura exacta.

- **Juego del caos (Sierpinski):** tres vértices. Se elige uno al azar y el punto salta a la **mitad** del camino. Se repite miles de veces y aparece el triángulo.
- **Dimensión:** $D = \ln 3 / \ln 2 \approx 1{,}585$.
- **Helecho de Barnsley:** 4 transformaciones con probabilidades distintas (≈ 1 %, 85 %, 7 %, 7 %). Una hace el tallo, otra las hojas sucesivas y dos las hojas laterales.
- **En la app:** elegir fractal, número de puntos y velocidad de dibujo.

## Diapositiva 9 · Valeria (módulo 3) — *ajustar al terminar el módulo*

**Mensaje:** se reescribe un texto y luego se dibuja.

- **Ejemplo con números (Koch):** axioma `F`; regla `F → F+F−−F+F`. Generación 1 tiene **4** `F`, generación 2 tiene **16**, generación 3 tiene **64**: crece como $4^n$.
- **Tortuga:** `F` avanza, `+` y `−` giran 60°, `[` y `]` guardan y recuperan posición (así se ramifica una planta).
- **Dimensión de Koch:** $D = \ln 4 / \ln 3 \approx 1{,}262$.
- **En la app:** editar la regla, el ángulo y las generaciones, y ver el dibujo al instante.

## Diapositivas 10–11 · Keyla (módulo 4)

**Mensaje:** un solo parámetro, la rugosidad, controla qué tan áspero es el terreno.

- **Diamond-square:** se parte de las 4 esquinas. En cada ronda el centro de cada cuadrado recibe el promedio de sus esquinas más un desplazamiento aleatorio, y el desplazamiento se multiplica por *r* en la ronda siguiente.
- **Rugosidad y dimensión:** $H = -\log_2 r$ y $D = 3 - H$. Con $r = 0{,}59$: $H \approx 0{,}76$ y $D \approx 2{,}24$. Con $r = 0{,}80$: $D \approx 2{,}68$.
- **Si $r < 0{,}5$:** $H > 1$, la superficie queda lisa y el panel muestra $D = 2$.
- **Aclarar siempre:** el valor de *D* del panel es una **estimación teórica** de la superficie, no una medición.
- **Semilla:** la misma semilla reproduce el mismo terreno (por defecto 4817).
- **En la app:** se dibuja en WebGL, con agua, cielo y niebla.

## Diapositivas 12–13 · Rodrigo (módulo 5) — *ajustar al terminar el módulo*

**Mensaje:** se puede medir qué tan fractal es una imagen contando cajas.

- **Pasos:** binarizar la imagen, cubrirla con cajas de lado ε, contar las cajas ocupadas *N(ε)* y repetir con varios ε.
- **Por qué log-log:** si $N(\varepsilon) \propto \varepsilon^{-D}$, en escala logarítmica queda una **recta** y su **pendiente** es *D*.
- **Validación (diap. 13):** generar Koch con el módulo 3 y medirlo con el módulo 5. Debe dar cerca de 1,262. También Sierpinski ≈ 1,585.
- **Ser honestos:** el resultado depende de la binarización y del rango de ε; un objeto real no es autosimilar hasta el infinito.

## Diapositiva 14 · Pieers (demostración en vivo)

1. Pulsar **Modo presentación** en el módulo 1 y avanzar con las flechas (8 escenas: de todo negro al conjunto, la órbita que escapa, el zoom y el vínculo con Julia).
2. Con **Vista dividida**, una persona del público elige el punto de Mandelbrot y se ve su Julia al instante.
3. Otra persona dicta la **semilla** del terreno.
4. Generar Koch y medir su dimensión.

⚠️ **Plan B:** si falla el proyector o el internet, reproducir el video. El propio módulo 1 lo genera con **Grabar video** (archivo `.webm` con el recorrido completo). La app también funciona sin internet abriendo `index.html`.

## Diapositivas 15–16 · Camila (cierre)

- Reglas simples producen estructuras complejas.
- Cada técnica tiene fortalezas y límites propios (diap. 15).
- La aplicación interactiva hace visible lo que la fórmula solo describe.
- La dimensión fractal conecta la teoría con imágenes reales.

---

## Preguntas probables del profesor

| Pregunta | Respuesta corta |
|---|---|
| ¿Por qué el conjunto de Mandelbrot es un fractal? | Su borde muestra estructura nueva a cualquier escala y se parece a sí mismo al ampliar (Figura 2.2 y 2.3). |
| ¿Por qué se usa la GPU? | Cada píxel es independiente, así que se calcula en paralelo. |
| ¿Por qué falla el zoom muy profundo? | La GPU usa números de 32 bits; al ampliar, dos píxeles vecinos dejan de distinguirse y la imagen se pixela. |
| ¿En el juego del caos, por qué sale la figura si es aleatorio? | Cada salto contrae el punto hacia el atractor; tras unos pocos pasos queda sobre él y los siguientes lo recubren. |
| ¿Qué diferencia hay entre IFS y L-system? | El IFS aplica transformaciones geométricas a un punto. El L-system reescribe texto y luego lo interpreta como dibujo. |
| ¿Por qué la cadena del L-system crece tanto? | Cada símbolo se reemplaza en paralelo: con Koch se multiplica por 4 en cada generación. |
| ¿La dimensión que muestra el terreno es medida? | No. Es una estimación teórica a partir de la rugosidad ($D = 3 - H$). Medirla sería tarea del módulo 5. |
| ¿Cómo se valida el box-counting? | Con formas de dimensión conocida: Koch ≈ 1,262 y Sierpinski ≈ 1,585. |
| ¿Qué fuentes usaron? | Mandelbrot (1967), Lindenmayer (1968), Barnsley y Demko (1985), Fournier et al. (1982), Liebovitch y Toth (1989). Con DOI en el informe. |
| ¿Usaron IA? | Sí, está registrado con fecha, hora y herramienta en el anexo del informe (bitácora). |

📌 Antes del 28/11, cada responsable revisa su sección con este guion y lo ajusta a su módulo terminado.
