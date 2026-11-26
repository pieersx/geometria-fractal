# Módulo 3 · L-systems

**Responsable:** Flores Cortez, Valeria Alexandra
**Estado:** prototipo listo (Canvas 2D)

Base de Valeria (árbol con ramas por nivel e irregularidad), rediseñada con el estilo de los módulos 1 y 4: lienzo a pantalla completa y panel flotante.

## Qué hace

- Reescritura paralela del axioma con reglas editables, incluidas reglas **estocásticas** con peso (`X(0.5)=F[+X]`) y semilla reproducible.
- Tortuga gráfica: `F G A B` dibujan, `f` avanza sin dibujar, `+ −` giran, `|` da media vuelta y `[ ]` ramifican.
- Siete ejemplos: curva y copo de Koch, triángulo de Sierpinski, curva del dragón, planta, árbol en un paisaje y bosque estocástico.
- Controles: generaciones, ángulo, ramas por nivel, número de árboles, irregularidad, viento, semilla, hojas y paisaje.
- **Ver crecer:** anima la tortuga en el orden en que lee la cadena.
- Zoom y arrastre con ratón, gestos táctiles o teclado (flechas, + / − y 0); exportación a PNG.
- Muestra símbolos, segmentos, hojas, la cadena de cada generación y la dimensión teórica de los fractales geométricos.
- Límites de seguridad: 1 500 000 símbolos y 400 000 segmentos.

## Para el informe

Capítulo 4: `docs/informe/capitulo-4.md`. Capturas en `docs/presentacion/capturas/modulo3-*.png`.
