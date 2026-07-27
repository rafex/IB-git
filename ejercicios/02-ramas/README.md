# 02 — Ramas: trabajar en paralelo

**Concepto:** Una rama es un marcador que apunta a un commit, no una copia de carpeta.

**Duración:** ~10 minutos

## Objetivo

Crear una rama `ana`, trabajar sobre `agenda.txt` en ella sin tocar `main`, y luego ver el grafo resultante con `git log --graph --all`.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea `taller-02/` con un repositorio que ya tiene dos commits en `main`.

### Paso 1 — Mira dónde estás parado

```bash
cd taller-02
git log --oneline          # ¿cuántos commits hay?
git branch                 # ¿qué ramas existen?
cat agenda.txt             # ¿cómo está el archivo?
```

### Paso 2 — Crea la rama `ana`

```bash
git branch ana             # crea la rama (no te mueve a ella)
git branch                 # ahora deberías ver main y ana
```

### Paso 3 — Trabaja en `ana`

```bash
git switch ana             # te mueves a la rama ana
git branch                 # el * te dice en cuál estás

# Edita agenda.txt: agrega una línea al final
# 3. Cierre

git add agenda.txt
git commit -m "agrega sección de cierre"
git log --oneline          # ¿cuántos commits ves ahora?
```

### Paso 4 — Compara las ramas

```bash
git switch main            # vuelve a main
cat agenda.txt             # ¿está la línea de cierre?
git log --oneline          # ¿está el commit de cierre?

# main no tiene el cambio porque trabajaste en ana
```

### Paso 5 — Visualiza el grafo

```bash
git log --oneline --graph --all
```

Deberías ver algo como:

```
* abc1234 (ana) agrega sección de cierre
* def5678 (HEAD -> main) agrega demo con archivos de texto
* a1b2c3d agrega agenda inicial
```

### Paso 6 — Trabaja en main

```bash
# En main, edita agenda.txt: agrega una línea de preguntas
# 3. Ronda de preguntas

git add agenda.txt
git commit -m "agrega ronda de preguntas"

git log --oneline --graph --all
```

Ahora las ramas divergen: `main` tiene "preguntas", `ana` tiene "cierre".

## Preguntas para responder

1. ¿Qué significa que una rama "apunte" a un commit?
2. ¿Cuántos commits existen en el repositorio si contamos todos?
3. Si hicieras `git switch ana` y luego `git log`, ¿verías el commit de "preguntas"? ¿Por qué?

## Verifica tu resultado

```bash
# Deberías ver dos ramas que divergen desde "agrega demo..."
git log --oneline --graph --all
```

Compara con `../../soluciones/02-ramas/log-esperado.txt`.
