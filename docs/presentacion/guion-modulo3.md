# Guion y guía del módulo 3 · L-systems

Para la exposición del **02/12/2026**. Expone: **Valeria Flores**. Duración de la demo: **3 minutos y medio**.

## 1. Antes de empezar

- Abrir `modulos/03-l-systems/index.html` en Chrome con pantalla completa (F11). Probarlo el día anterior en la computadora del aula.
- Dejar elegido el ejemplo **Curva de Koch**.
- Si algo se desordena, el botón **Reiniciar** vuelve al ejemplo original.
- El panel muestra solo lo esencial. El axioma, las reglas, el paso a paso y la cadena de cada generación están en **⚙ Opciones avanzadas**, que se abre con un clic. Ábrelo solo cuando el guion lo indique y vuelve a cerrarlo.

## 2. Guion de la demostración (3 minutos y medio)

| Tiempo | Acción en pantalla | Qué decir |
|---|---|---|
| 0:00 | **Curva de Koch**, generación 0 → subir hasta 4 | «Un L-system es una regla de texto. El axioma es `F`; la regla cambia cada `F` por `F+F−−F+F`. Cada generación reemplaza **todos** los símbolos a la vez.» |
| 0:30 | Abrir **⚙ Opciones avanzadas** y bajar hasta «Cadena en cada generación» | «Aquí se ve la cadena de cada generación: crece ×4. Por eso la dimensión es ln 4 / ln 3 ≈ 1,262, que aparece en el panel como D.» |
| 0:50 | En Opciones avanzadas, cambiar el axioma a `F--F--F` | «Solo cambié el punto de partida: ahora son tres curvas sobre un triángulo, el copo de nieve. Perímetro infinito, área finita.» |
| 1:10 | **Planta ramificada**, generación 2 → en Opciones avanzadas, **👣 Paso a paso** → ▶ | «La tortuga lee la cadena símbolo por símbolo. Con `[` guarda su posición en una pila y con `]` vuelve a ella: así nacen las ramas.» (señalar los círculos azules de la pila; al terminar, pulsar **✕ Salir** y cerrar Opciones avanzadas) |
| 1:45 | **Árbol en un paisaje** → **▶ Ver crecer** | «El árbol se dibuja en el mismo orden en que se lee la cadena. Con “Ramas por nivel” cambia la regla automáticamente.» (mover el control de 3 a 5) |
| 2:15 | **Bosque estocástico** → **🎲 Otro** dos veces | «Con reglas estocásticas cada `X` elige al azar entre tres producciones. La semilla hace que el bosque sea reproducible: así se genera vegetación en videojuegos.» |
| 2:30 | **Árbol 3D** → arrastrar para girar → subir la «Gravedad» | «La misma idea en 3D: la tortuga tiene tres vectores (H, L, U) y gira con `& ^ \ /`. Las ramas son tubos de triángulos que dibuja la GPU con WebGL, como los módulos 1 y 4. El giro de 137,5° es el ángulo áureo; la gravedad curva las ramas.» |
| 2:50 | **Curva de Hilbert 3D**, generación 3 | «Una sola curva que pasa por los 512 puntos de un cubo sin cruzarse: un fractal que llena el espacio.» |
| 3:10 | Cierre | «Pocas reglas, mucha estructura: esa es la fuerza de los L-systems. Su debilidad es el crecimiento exponencial; por eso cada ejemplo limita las generaciones.» |

## 3. Cómo funciona el código (para explicarlo con tus palabras)

El archivo `modulos/03-l-systems/index.html` sigue estas etapas, en este orden:

1. **`parseRules()`** lee las reglas del cuadro de texto. `X(0.34)=...` es una regla estocástica con peso 0,34. Si un símbolo tiene varias reglas, se elige una al azar según su peso.
2. **`expand()`** hace la **reescritura paralela**: recorre la cadena y reemplaza cada símbolo por su producción. Lo repite tantas veces como generaciones haya. Corta en 1 500 000 símbolos para no colgar el navegador.
3. **`compile()`** convierte la cadena en una lista de números (instrucciones de tortuga) y revisa que los corchetes estén bien cerrados.
4. **`turtle()`** es la **tortuga gráfica**: guarda posición `(x, y)` y ángulo, avanza con `F`, gira con `+ −` y usa una **pila** para `[ ]`. Devuelve la lista de segmentos.
5. **`draw()`** dibuja los segmentos en **Canvas 2D**, agrupados por color y grosor para que sea rápido. El grosor, las hojas, el viento y el paisaje son **añadidos gráficos**: no forman parte del L-system.
6. **Modo 3D:** `turtle3()` hace lo mismo con tres vectores de orientación, `buildMesh3()` convierte los segmentos en tubos de triángulos y `draw3()` los dibuja con **WebGL**.

Tu base original está en el árbol: `treeRules()` genera la regla según el número de ramas, y la **irregularidad** desvía un poco cada giro.

## 4. Preguntas probables del profesor

**¿Qué diferencia hay entre una generación y un paso?**
Una generación reescribe toda la cadena a la vez. Un paso es un avance de la tortuga al leer un símbolo de dibujo.

**¿Por qué la reescritura es «paralela»?**
Porque las reglas se aplican a todos los símbolos al mismo tiempo, no uno por uno. Así lo definió Lindenmayer (1968) para modelar células que se dividen a la vez.

**¿Para qué sirven `X` e `Y` si no dibujan?**
Son símbolos de control: marcan dónde seguirá creciendo la planta en la siguiente generación.

**¿Qué hace la pila?**
`[` guarda la posición y la dirección; `]` las recupera. Gracias a eso, después de dibujar una rama la tortuga vuelve al punto donde nació y puede empezar otra.

**¿Por qué limitan las generaciones?**
Porque la cadena crece de forma exponencial. La planta pasa de 4 096 segmentos en la generación 4 a 32 768 en la 5.

**¿Qué es un L-system estocástico?**
Uno en el que un símbolo tiene varias producciones con probabilidades. Las mismas reglas dan árboles distintos de una misma «especie».

**¿Por qué sale siempre el mismo bosque con la misma semilla?**
Porque el azar sale de un generador pseudoaleatorio (mulberry32) que depende solo de la semilla.

**¿El árbol simula biología real?**
No. El L-system da el esqueleto ramificado; el grosor, las hojas, el viento y el paisaje son decisiones gráficas.

**¿Cómo se calcula la dimensión que aparece?**
Es la dimensión **teórica** de autosimilitud: si una regla cambia un segmento por *N* copias reducidas a 1/*s*, *D* = ln *N* / ln *s*. En Koch, *N* = 4 y *s* = 3. No se mide sobre el dibujo (eso lo hace el módulo 5).

**¿Cómo gira la tortuga en 3D?**
Lleva tres vectores perpendiculares: H (adelante), L (izquierda) y U (arriba). `+ −` rotan H y L alrededor de U; `& ^` rotan H y U alrededor de L; `\ /` rotan L y U alrededor de H. Son rotaciones de dos ejes con seno y coseno, como una matriz de rotación.

**¿Qué es el tropismo?**
Después de cada paso, la dirección H se inclina un poco hacia un vector fijo (aquí, hacia abajo). Imita la gravedad; con un valor negativo, la rama sube como buscando luz.

**¿Cómo se dibuja el 3D?**
Cada segmento se convierte en un tubo de 7 u 8 caras (triángulos) con sus normales. El *vertex shader* aplica la cámara (matrices de perspectiva y vista) y el viento; el *fragment shader* calcula la luz difusa, la luz ambiental y la niebla.

**¿Por qué 137,5°?**
Es el ángulo áureo: al girar cada rama ese ángulo respecto de la anterior, nunca quedan alineadas. Muchas plantas reparten así sus hojas (filotaxis).

**¿Por qué Canvas 2D y no WebGL en la vista 2D?**
Porque se dibujan líneas de distinto grosor y Canvas 2D lo resuelve directamente. Agrupando los trazos se mantiene la animación fluida.
