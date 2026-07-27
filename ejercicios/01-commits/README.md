# 01 — Commits: seguir un archivo

**Concepto:** Git guarda instantáneas, no diferencias entre carpetas.

**Duración:** ~10 minutos

## Objetivo

Crear tres commits que representen los estados A, B, C de `agenda.txt`:
- **A**: contenido inicial
- **B**: agregas la demo
- **C**: reordenas secciones

Al terminar debes poder leer el historial con `git log` y explicar qué guarda cada commit.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea una carpeta `taller-01/` con un repositorio Git vacío y un archivo `agenda.txt`.

### Paso 1 — Commit A (inicio)

```bash
cd taller-01
cat agenda.txt          # mira el archivo inicial
git status              # ¿en qué lugar están los cambios?
git add agenda.txt      # mueve a staging
git status              # ¿cambió algo?
git commit -m "agrega agenda inicial"
git log --oneline       # tu primer commit
```

### Paso 2 — Commit B (agrega demo)

Edita `agenda.txt` con tu editor. Agrega una línea entre "Bienvenida" y "Preguntas":

```
1. Bienvenida
2. Demo con archivos de texto
3. Preguntas
```

Guarda y repite el ciclo:

```bash
git status
git add agenda.txt
git commit -m "agrega demo con archivos de texto"
git log --oneline
```

### Paso 3 — Commit C (reordena cierre)

Edita `agenda.txt`. Intercambia el orden de las líneas 2 y 3:

```
1. Bienvenida
2. Preguntas
3. Demo con archivos de texto
```

```bash
git status
git add agenda.txt
git commit -m "reordena cierre: preguntas antes de la demo"
git log --oneline
```

### Paso 4 — Explora

```bash
git log                    # historial completo con autor y fecha
git log --oneline          # versión compacta
git show HEAD              # último commit
git show HEAD~1            # penúltimo commit
git diff HEAD~2 HEAD       # ¿cuánto cambió entre A y C?
```

## Preguntas para responder

1. ¿Qué tres cosas contiene un commit? (pista: qué, por qué, de dónde)
2. Si tuvieras que volver al estado del commit A, ¿cómo lo harías?
3. ¿Por qué crees que `git log` muestra los commits en orden inverso?

## Verifica tu resultado

```bash
# Deberías ver 3 commits en orden inverso (C → B → A)
git log --oneline
```

Compara con `../../soluciones/01-commits/log-esperado.txt`.
