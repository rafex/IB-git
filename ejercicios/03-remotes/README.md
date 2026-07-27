# 03 — Remotes: clone, fetch, pull, push

**Concepto:** Distinguir los cuatro movimientos entre repo local y remote.

**Duración:** ~15 minutos

## Objetivo

Trabajar con un repositorio bare local como `origin`, clonarlo en dos copias (`ana` y `luis`), hacer cambios en cada una, y practicar fetch, pull y push.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea:
- `taller-03/origin/` — repositorio bare (simula GitHub)
- `taller-03/ana/` — clon local de Ana
- `taller-03/luis/` — clon local de Luis

### Paso 1 — Entiende la estructura

```bash
ls taller-03/
# Verás: origin/  ana/  luis/

cd taller-03/ana
git remote -v              # ¿a dónde apunta origin?
git log --oneline          # ¿cuántos commits hay?
```

### Paso 2 — Ana hace un cambio y lo publica

```bash
cd taller-03/ana
cat agenda.txt              # ¿cómo está el archivo?

# Agrega una sección:
# 3. Ronda de preguntas

git add agenda.txt
git commit -m "agrega ronda de preguntas"
git push                    # publica en origin
```

### Paso 3 — Luis trae el cambio de Ana

```bash
cd taller-03/luis
cat agenda.txt              # ¿está la sección de preguntas? (no debería)

git fetch                   # trae referencias, no modifica archivos
cat agenda.txt              # ¿sigue sin estar? (sí, fetch no modifica)

git log --oneline           # ¿ves el commit de Ana?

git pull                    # fetch + integrar
cat agenda.txt              # ahora sí deberías verlo
```

### Paso 4 — Luis hace su cambio y ambos sincronizan

```bash
# En luis, agrega otra sección:
# 4. Demo final

git add agenda.txt
git commit -m "agrega demo final"
git push
```

```bash
# En ana, trae el cambio de Luis:
cd taller-03/ana
git pull
git log --oneline
```

### Paso 5 — Reflexión sobre `fetch` vs `pull`

```bash
# fetch es seguro: no modifica tus archivos
git fetch
# Puedes inspeccionar qué trajo antes de integrar:
git log origin/main
git diff main origin/main

# pull es fetch + merge/rebase; integra de inmediato
git pull
```

## Preguntas para responder

1. ¿Qué diferencia hay entre `git fetch` y `git pull`?
2. ¿Qué pasaría si Ana y Luis editan la misma línea y ambos hacen push?
3. ¿Por qué `clone` se usa una sola vez pero `pull` se usa a diario?

## Bonus: simular con GitHub real

Si tienes cuenta de GitHub, ejecuta:

```bash
bash configurar-github.sh
```

Esto te guiará para crear un repo en GitHub y reconfigurar los remotos.

## Verifica tu resultado

```bash
# En ambos clones deberías ver 4 commits (2 base + Ana + Luis)
cd taller-03/ana  && git log --oneline
cd taller-03/luis && git log --oneline
```

Compara con `../../soluciones/03-remotes/log-esperado.txt`.
