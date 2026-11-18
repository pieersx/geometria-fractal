# Cómo trabajamos

## Ramas

- `main` siempre debe abrir sin errores. No se trabaja directamente en ella.
- Una rama por tarea, con el nombre `modulo/NN-nombre` (por ejemplo `modulo/02-ifs-chaos-game`) o `docs/capitulo-2`.
- Se integra a `main` mediante Pull Request revisado por otra persona.

## Reglas

1. Cada persona edita **solo la carpeta de su módulo**. Si necesitas cambiar algo común (portada, README), avisa al grupo.
2. Cada módulo es **autocontenido**: un `index.html` que funciona sin instalar nada. Si usas librerías externas, cárgalas con una versión fija.
3. Los módulos tienen una interfaz parecida: panel de controles a la izquierda y lienzo a pantalla completa (ver módulo 1 como referencia).
4. Los commits son pequeños y en español, con prefijo: `feat:`, `fix:`, `docs:`, `chore:`.

## Informe

- Un capítulo por módulo en `docs/informe/`, en Markdown, con el mismo esquema: descripción del algoritmo, fortalezas, debilidades y caso práctico.
- Las citas y la bibliografía siguen el formato APA. Antes de citar un paper, verifica el DOI.

## Uso de IA

Cada vez que uses una IA para este trabajo, agrega una fila en [`docs/bitacora-ia.md`](docs/bitacora-ia.md) con **fecha, hora, herramienta y propósito**. La rúbrica lo exige.
