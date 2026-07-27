# 04 — Merge, Rebase y ff-only

**Concepto:** Tres formas de integrar ramas, cada una con un propósito distinto.

**Duración:** ~15 minutos

## Objetivo

Practicar las tres estrategias de integración sobre un mismo escenario y entender cuándo usar cada una.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea `taller-04/` con dos ramas que divergen desde un punto común:
- `main`: tiene cambios en `agenda.txt`
- `feature`: tiene cambios distintos en `agenda.txt` (líneas que no se tocan)

### Parte A — Merge (conserva el encuentro)

```bash
cd taller-04

# Mira el estado inicial
git log --oneline --graph --all

# Estás en main. Une feature con merge:
git merge feature

# Ahora hay un merge commit (mensaje por defecto o lo personalizas)
git log --oneline --graph --all
```

El grafo muestra que `feature` se unió a `main` con un commit de merge que tiene dos padres.

### Parte B — Rebase (reacomoda una rama)

```bash
# Resetea al estado anterior
git reset --hard origin/main 2>/dev/null || git reset --hard HEAD~1

# Crea una rama nueva para probar rebase
git switch -c mi-cambio

# Edita agenda.txt: agrega "4. Cierre" al final
git add agenda.txt
git commit -m "agrega cierre"

# Vuelve a main y simula que alguien más avanzó
git switch main
# Edita agenda.txt: agrega "4. Notas" al final
git add agenda.txt
git commit -m "agrega notas"

# main avanzó. Ahora mi-cambio está "atrás".
# En vez de merge, hacemos rebase:
git switch mi-cambio
git rebase main

# Los commits de mi-cambio se reaplican sobre el main actual
git log --oneline --graph --all
```

¿Ves la diferencia? No hay merge commit. El historial es lineal.

### Parte C — ff-only (avanzar sin bifurcar)

```bash
# Resetea
git switch main
git reset --hard HEAD~1

# Crea una rama que esté "adelante" de main
git switch -c adelante

# Edita agenda.txt: agrega "4. Contacto"
git add agenda.txt
git commit -m "agrega contacto"

# main está atrás de adelante. Intenta ff-only:
git switch main
git merge --ff-only adelante

# Avanzó limpiamente: main apunta al mismo commit que adelante
git log --oneline --graph --all
```

Si intentas `--ff-only` cuando hay bifurcación real, falla:

```bash
# Prueba forzar un escenario donde ff-only falla:
git switch -c conflicto
# Edita agenda.txt: cambia la línea 1
git add agenda.txt
git commit -m "cambia bienvenida"

git switch main
# Edita agenda.txt: cambia la línea 1 de forma distinta
git add agenda.txt
git commit -m "cambia bienvenida distinto"

git merge --ff-only conflicto
# Error: fatal: Not possible to fast-forward, aborting.
```

## Resumen de decisión

| Si quieres... | Usa... |
|---------------|--------|
| Conservar el encuentro de dos ramas | `git merge` |
| Limpiar tu rama local antes de compartirla | `git rebase` |
| Avanzar sin crear merge commit (solo si es posible) | `git merge --ff-only` |

## Regla de oro

> No hagas rebase de una rama que ya compartiste con otras personas.
> El rebase reescribe commits (cambia sus hashes). Si alguien ya tiene
> los commits viejos, se crea una divergencia difícil de resolver.

## Preguntas para responder

1. ¿Qué pasa con los hashes de los commits después de un rebase?
2. ¿Por qué `ff-only` es una "baranda de seguridad"?
3. Si trabajas solo en una rama local, ¿prefieres merge o rebase? ¿Por qué?

## Verifica tu resultado

Compara con `../../soluciones/04-merge-rebase/`.
