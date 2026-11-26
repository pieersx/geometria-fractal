# Plan de entrega: informe, presentación y aplicación

**Curso:** Computación Visual · **Grupo 8** · **Exposición: 02/12/2026 (20 minutos)**
Documento vivo: se actualiza al cerrar cada tarea. Estado al 26/11/2026 (revisión final).

## 1. Metas acordadas

| Entregable | Meta | Estado |
|---|---|---|
| Informe (APA) | 25–30 páginas, con capturas, 1–2 fórmulas y un diagrama por capítulo. Sin relleno. | PDF regenerado el 26/11 (46 páginas con portada, índices y anexo de la bitácora), con capturas reales. Falta la revisión de APA y ortografía |
| Presentación | 14–17 diapositivas, poco texto y una imagen grande por diapositiva. PDF para compartir. | PDF regenerado el 26/11 (19 diapositivas; la meta era 14–17) |
| Aplicación | 5 módulos funcionando | Los 5 módulos están integrados en `main` y revisados (código, textos y datos del informe). Falta la prueba en el equipo de la exposición |
| Video | 1 video de 2–3 minutos con recorrido por los 5 módulos | No existe |
| Bitácora de IA | Fecha, hora real, herramienta y tema de cada uso | Horas de Pieers completas hasta el 26/11 (11:45); falta registrar el uso de IA de los demás integrantes |

## 2. Cumplimiento de la rúbrica

| Criterio | Qué lo cumple | Responsable | Estado |
|---|---|---|---|
| Informe impreso y PDF | PDF final revisado e impresión a color anillada | Camila | 🟡 |
| PDF de la presentación | PDF definitivo | Pieers | 🟡 |
| Formato APA | Citas en el texto y lista de referencias coherentes | Camila | 🟡 |
| Índice, presentación o resumen, conclusión | Ya redactados; ajustar al final | Camila | 🟡 |
| Algoritmos, fortalezas, debilidades y casos prácticos | Esquema de cada capítulo | Cada responsable de módulo | 🟡 |
| Mínimo 2 artículos de revista | 5 artículos de revista verificados en Crossref | Camila | ✅ |
| Referencia del uso de IA | `docs/bitacora-ia.md` con hora real | Todos | 🔴 |
| Uniformidad, ortografía y compaginación | Revisión final el 28/11 | Camila | 🟡 |
| Multimedia y videos | Video demo de 2–3 minutos | Pieers | 🔴 |
| Aplicación gráfica | 5 módulos (o versión mínima, ver §6) | Cada responsable | 🟡 |
| Coevaluación | Tabla de aportes (§8) | Todos | 🟡 |
| Puntualidad | Cronograma de §3 | Todos | 🟡 |

## 3. Cronograma

| Fecha | Qué debe estar listo |
|---|---|
| **Hasta el 24/11** | Módulos 2, 3 y 5 funcionando, cada uno en su rama |
| **25–27/11** | Integración en `main`, capturas reales en el informe, correcciones por módulo |
| **26/11** | **Fecha de corte:** el módulo que no funcione pasa a versión mínima (§6) |
| **28/11** | Informe y PPT congelados. Camila revisa APA y ortografía |
| **29–30/11** | Video grabado, PDF final, bitácora completa |
| **30/11 o 01/12** | Impresión a color, 1 copia anillada |
| **01/12** | Ensayo completo con cronómetro y plan B (video) a mano |
| **02/12** | Exposición |

## 4. Tareas por persona

| Persona | Módulo y tareas |
|---|---|
| Pachas Auris, Pieers Fernando | Módulo 1 (listo). Capítulo 2. Video demo, PDF de la PPT, bitácora de las sesiones del 18/11. |
| Cerna Aguilar, Emily Andrea | Módulo 2 (IFS y Chaos Game): prototipo listo; **revisarlo, probarlo y explicarlo sin leer**. Capítulo 3 ya ajustado: revisar el texto. |
| Flores Cortez, Valeria Alexandra | Módulo 3 (L-systems): listo, con modo 3D y paso a paso. Capítulo 4. |
| Sihuacollo Sierra, Keyla Noemi | Módulo 4 (listo). Capítulo 5. Demo participativa (semilla del terreno). |
| Puente Carmen, Rodrigo Joaquin | Módulo 5 (box-counting): prototipo listo y validado; **revisarlo, probarlo con una imagen real y explicarlo sin leer**. Capítulos 6 y 8.2 ya ajustados: revisar el texto. |
| Bada Watanave, Camila del Rosario | Integración y formato APA/ortografía. Verificación de DOI. Impresión. Abre y cierra la exposición. |

📌 Nadie edita la carpeta de otra persona (ver `CONTRIBUTING.md`).

## 5. Ideas para destacar

1. **Validación del módulo 5.** Medir con box-counting la curva de Koch (≈ 1,262) y el triángulo de Sierpinski (≈ 1,585) y mostrar que la app da un valor cercano al teórico.
2. **Hilo conductor.** La curva de Koch se genera con un L-system (módulo 3) y se mide con box-counting (módulo 5). La app se presenta como un conjunto.
3. **Demo participativa.** Una persona del público elige la semilla del terreno o el punto de zoom en Mandelbrot. El video queda como respaldo.

## 6. Plan B: fecha de corte del 26/11

Si un módulo no funciona el 26/11, se entrega una **versión mínima**: un solo control y una sola visualización que sí funcionen. El informe describe el algoritmo completo. La app y la presentación solo muestran lo que sí llegó. No se promete lo que no existe.

## 7. Esquema de cada capítulo y diapositiva

1. **Idea en una frase.**
2. **Paso a paso con un ejemplo numérico pequeño.**
3. **Qué se ve en la app** (captura y parámetros).

Además, en cada capítulo: fortalezas, debilidades y un caso práctico de aplicación. Antes del 28/11, cada responsable explica su módulo en voz alta a alguien del grupo, sin leer.

## 8. Referencias

- Cada DOI de `docs/informe/bibliografia.md` se abre una vez y se marca como verificado. **Hutchinson (1981)** va primero: confirmar título y páginas 713–747 en el DOI.
- Cada capítulo cita al menos una referencia, y toda cita del texto está en la lista.
- Libros clásicos (Mandelbrot 1982, Barnsley 1988, Prusinkiewicz y Lindenmayer 1990): solo se agregan tras comprobar editorial, año y edición en Crossref o WorldCat.
- Redacción con palabras propias. No se copian párrafos de artículos ni de otros informes.

## 9. Bitácora de IA

Cada persona anota en `docs/bitacora-ia.md` lo que usó, con fecha, **hora real**, herramienta y tema, apenas lo hace. Las horas de las sesiones del 18/11 las completa Pieers revisando el historial. Si no se conoce una hora exacta, se escribe "tarde, aprox." y nunca una hora inventada.

## 10. Coevaluación: tabla de aportes

Una línea por persona, actualizada al cerrar cada tarea. Los commits y las ramas sirven de evidencia.

| Persona | Aporte entregado | Evidencia (rama o commit) |
|---|---|---|
| Pachas Auris, Pieers Fernando | | |
| Cerna Aguilar, Emily Andrea | | |
| Flores Cortez, Valeria Alexandra | | |
| Sihuacollo Sierra, Keyla Noemi | | |
| Puente Carmen, Rodrigo Joaquin | | |
| Bada Watanave, Camila del Rosario | | |

## 11. Exposición (20 minutos)

| Bloque | Quién | Tiempo aprox. |
|---|---|---|
| Apertura y concepto de fractal | Camila | 3 min |
| Módulos 1 a 5, con demo en vivo | Cada responsable | 2–3 min cada uno |
| Cierre y conclusiones | Camila | 2 min |
| Preguntas | Todos | resto |

Diapositivas: 14–17, con el módulo en una diapositiva y la demo en vivo. Cada integrante debe poder explicar su algoritmo sin leer.

## 12. Decisión: el modo «paso a paso» solo en el módulo 1

Se acordó el 26/11 que el modo explicativo («construir desde cero», órbita de un punto, vista dividida, recorrido guiado y grabación de video) **queda solo en el módulo 1**. Los módulos 2, 4 y 5 se mantienen con pocos controles. El módulo 3 conserva su paso a paso y su modo 3D porque ya estaban terminados y documentados. No se pide nada parecido a los demás módulos.

## 13. Pendientes al 26/11

| Tarea | Responsable |
|---|---|
| Revisar los prototipos de los módulos 2 y 5, abrir sus PR y fusionarlos en `main` | Emily y Rodrigo, con Pieers |
| Probar toda la app en el equipo con el que se expone (la app necesita WebGL en los módulos 1, 3 y 4) | Pieers |
| Regenerar los PDF del informe y de la presentación con los capítulos 3, 6 y 8 ajustados | Pieers y Camila |
| Completar la bitácora de IA de las sesiones del 26/11 | Pieers |
| Encuadre más cercano de la isla en el módulo 4 | Keyla |
