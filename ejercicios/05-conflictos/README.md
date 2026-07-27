# 05 — Conflictos: cuando Git necesita ayuda humana

**Concepto:** Un conflicto ocurre cuando dos personas editaron
la misma zona de un archivo. Git no puede decidir por el equipo:
necesita que un humano lea ambas versiones y tome una decisión.

**Duración:** ~10 minutos

## Objetivo

Crear intencionalmente un conflicto en `acuerdos.txt`, leer los marcadores
de conflicto, resolverlos manualmente y completar la integración.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea `taller-05/` con dos ramas (`ana` y `luis`) que editaron la misma línea de `acuerdos.txt`.

### Paso 1 — Entiende el escenario

```bash
cd taller-05
git log --oneline --graph --all
git branch

cat acuerdos.txt          # contenido base
```

### Paso 2 — Mira qué cambió cada rama

```bash
# Estando en main...
git diff main ana         # ¿qué cambió Ana?
git diff main luis        # ¿qué cambió Luis?
```

Ambos editaron la misma línea. Esto va a generar un conflicto.

### Paso 3 — Provoca el conflicto

```bash
# Integra la rama de Ana primero
git merge ana
# OK, sin conflictos (es la primera en entrar)

# Ahora integra la de Luis
git merge luis
```

Verás algo como:

```
Auto-merging acuerdos.txt
CONFLICT (content): Merge conflict in acuerdos.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### Paso 4 — Lee el conflicto

Abre `acuerdos.txt` con tu editor:

```
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
<<<<<<< HEAD
- Confirmar asistencia antes del evento
=======
- Preparar sala virtual
>>>>>>> luis
```

Los marcadores significan:

- `<<<<<<< HEAD` — tu versión actual (lo que entró con Ana)
- `=======` — separador entre versiones
- `>>>>>>> luis` — la versión de la rama que intentas integrar

### Paso 5 — Resuelve el conflicto

La resolución no es "borrar las marcas". Es **tomar una decisión humana** sobre qué combinación representa al equipo.

Edita `acuerdos.txt` para que quede así:

```
- Revisar cambios antes de las 16:00
- Enviar resumen al equipo
- Confirmar asistencia antes del evento
- Preparar sala virtual
```

Quitaste los marcadores y decidiste conservar ambas líneas. Podrías haber elegido solo una, o redactar algo nuevo.

### Paso 6 — Completa la integración

```bash
git status                # acuerdos.txt aparece como "both modified"
git add acuerdos.txt      # marcas el conflicto como resuelto
git status                # "all conflicts fixed"
git commit -m "resuelve conflicto: conserva ambas líneas del acuerdo"
git log --oneline --graph --all
```

### Bonus: cancela un merge conflictivo

Si alguna vez quieres abortar y volver a intentar:

```bash
git merge --abort         # vuelve al estado anterior al merge
```

## El flujo de resolución

```
1. LEER        → entender qué cambió cada rama
2. CONVERSAR    → si es con otra persona, acordar el resultado
3. EDITAR       → quitar marcadores, escribir la decisión final
4. COMPROBAR    → git diff para verificar que el archivo quedó bien
5. COMMIT       → git add + git commit
```

## Preguntas para responder

1. ¿Por qué Git no puede resolver un conflicto automáticamente?
2. ¿Qué hubiera pasado si Ana y Luis editan líneas distintas?
3. ¿Cómo se previenen los conflictos? (pista: la presentación)

## Verifica tu resultado

Compara con `../../soluciones/05-conflictos/`.
