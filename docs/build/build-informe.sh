#!/usr/bin/env bash
# Atajo: genera docs/informe/informe-geometria-fractal.pdf (ver build-informe.py)
set -euo pipefail
exec python3 "$(dirname "$0")/build-informe.py"
