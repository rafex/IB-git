# Makefile — Taller Git para colaborar
#
# Uso:
#   make            → muestra esta ayuda
#   make slide-07   → ejecuta el demo de la diapositiva 07
#   make clean      → limpia el workspace de demos

include helpers/common.mk
include helpers/slides.mk

# Target por defecto
.DEFAULT_GOAL := help
