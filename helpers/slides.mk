# slides.mk — Targets de make por diapositiva
# Fuente: helpers/slides.mk

# ─── Diapositiva 07: Sigamos un archivo de texto ─────────────────────────────

slide-07: $(WS)
	@$(call run_demo,07-commits.sh)

# ─── Diapositiva 10: Una rama es un marcador ─────────────────────────────────

slide-10: $(WS)
	@$(call run_demo,10-ramas.sh)

# ─── Diapositiva 14: Los cuatro movimientos ──────────────────────────────────

slide-14: $(WS)
	@$(call run_demo,14-remotes.sh)

# ─── Diapositiva 17: Merge → Integrar cambios ────────────────────────────────

slide-17: $(WS)
	@$(call run_demo,17-merge.sh)

# ─── Diapositiva 19: Rebase → reacomoda una línea sobre otra ─────────────────

slide-19: $(WS)
	@$(call run_demo,19-rebase.sh)

# ─── Diapositiva 21: ff-only → integrar sin bifurcación ──────────────────────

slide-21: $(WS)
	@$(call run_demo,21-ffonly.sh)

# ─── Diapositiva 22: ¿Cuándo aparece un conflicto? ───────────────────────────

slide-22: $(WS)
	@$(call run_demo,22-conflictos.sh)

# ─── Diapositiva 26: Mini laboratorio con archivos de texto ──────────────────

slide-26: $(WS)
	@$(call run_demo,26-laboratorio.sh)

# ─── Limpieza ─────────────────────────────────────────────────────────────────

clean:
	@rm -rf $(WS)
	@echo "Workspace $(WS)/ eliminado."

# ─── Todos los demos en secuencia ─────────────────────────────────────────────

demo-all: $(WS)
	@bash helpers/demos/run-all.sh

# ─── Todos los demos sin pausas (para verificación rápida) ────────────────────

demo-all-fast: $(WS)
	@SKIP_PAUSE=1 bash helpers/demos/run-all.sh

.PHONY: slide-07 slide-10 slide-14 slide-17 slide-19 slide-21 slide-22 slide-26 clean demo-all demo-all-fast
