# common.mk — Variables y funciones compartidas para todos los slides
# Fuente: helpers/common.mk

WS       := workspace-slides
HELPERS  := helpers
LIB      := $(HELPERS)/lib
DEMOS    := $(HELPERS)/demos
LOGGER   := $(LIB)/logger.sh

# Colores para make
C_GREEN  := \033[32m
C_CYAN   := \033[36m
C_BOLD   := \033[1m
C_RESET  := \033[0m

# Asegura que el workspace exista
$(WS):
	@mkdir -p $(WS)

# Limpia el workspace y lo recrea fresco
ws-fresh: guard-args
	@rm -rf $(WS)
	@mkdir -p $(WS)
	@echo "Workspace limpio: $(WS)/"

guard-args:
	@if [ -z "$(strip $(MAKECMDGOALS))" ]; then true; fi

# Helper: ejecuta un script demo con logger cargado
define run_demo
	@if [ ! -f "$(LOGGER)" ]; then \
		echo "ERROR: no se encuentra $(LOGGER)"; exit 1; \
	fi
	@if [ ! -f "$(DEMOS)/$(1)" ]; then \
		echo "ERROR: demo no encontrado: $(DEMOS)/$(1)"; exit 1; \
	fi
	@bash -c "source $(LOGGER) && source $(DEMOS)/$(1)"
endef

# Muestra todos los targets disponibles
help:
	@echo ""
	@echo "  $(C_BOLD)Taller Git para colaborar — Makefile de demos$(C_RESET)"
	@echo ""
	@echo "  $(C_CYAN)Uso:$(C_RESET)  make <target>"
	@echo ""
	@echo "  $(C_BOLD)Demos por diapositiva:$(C_RESET)"
	@echo "    make slide-07    Commits: agenda.txt A → B → C"
	@echo "    make slide-10    Ramas: crear, divergir, visualizar"
	@echo "    make slide-14    Remotos: clone, fetch, pull, push"
	@echo "    make slide-17    Merge: unir dos ramas"
	@echo "    make slide-19    Rebase: reacomodar commits"
	@echo "    make slide-21    ff-only: avanzar sin merge commit"
	@echo "    make slide-22    Conflictos: crear y resolver"
	@echo "    make slide-26    Laboratorio: Ana y Luis colaboran"
	@echo ""
	@echo "  $(C_BOLD)Utilidades:$(C_RESET)"
	@echo "    make clean       Limpiar workspace de demos"
	@echo "    make help        Esta ayuda"
	@echo ""

.PHONY: help clean ws-fresh guard-args
