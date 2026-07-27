# Guía del facilitador — Git para colaborar

> Esta guía complementa las diapositivas. Cada bloque explica qué decir,
> qué demostrar y qué ejercicios acompañan.

---

## Flujo general del taller (~90 min)

| Bloque | Diapositivas | Tiempo | Ejercicio |
|--------|-------------|--------|-----------|
| Apertura | 1-5 | 5 min | — |
| Modelo mental | 6-12 | 15 min | 01-commits |
| Remotos | 13-19 | 15 min | 03-remotes |
| Ciclo diario | 20-22 | 10 min | 02-ramas |
| Integración | 23-34 | 20 min | 04-merge-rebase, 05-conflictos |
| Laboratorio | 35-41 | 15 min | 06-laboratorio |
| Cierre | 42-43 | 5 min | — |

---

## Bloque 1 — Apertura (diapositivas 1-5)

**Qué decir:**
- La anécdota del meme del viernes es el gancho emocional
- Pregunta al grupo: "¿A quién le ha pasado algo parecido?"
- Presenta la promesa: no vamos a memorizar recetas

**No hace falta ejercicio.** Es solo contexto.

---

## Bloque 2 — Modelo mental (diapositivas 6-12)

**Conceptos a transmitir:**
1. Git guarda instantáneas (commits), no diferencias entre carpetas
2. Un commit tiene: qué cambió (diff), por qué (mensaje), de dónde viene (parent)
3. Los 4 lugares: working tree, staging, local, remote
4. Una rama es un marcador que apunta a un commit

**Ejercicio: 01-commits**

Antes del ejercicio:
- Mostrar en vivo `git init`, `git add`, `git commit`
- Mostrar `git log` después de cada commit
- Señalar: "esto es una instantánea, no un diff"

Durante el ejercicio:
- Los participantes crean los 3 commits de `agenda.txt`
- Tiempo: ~7 min
- Recorrer la sala verificando que `git log --oneline` muestre 3 commits

Después del ejercicio:
- Preguntar: "¿Qué pasaría si quisieras ver cómo estaba el archivo en el commit A?"
- Mostrar: `git show HEAD~2:agenda.txt`
- Reforzar: "el historial está completo, puedes volver a cualquier punto"

---

## Bloque 3 — Remotos (diapositivas 13-19)

**Conceptos a transmitir:**
1. Cada persona tiene una copia completa del historial
2. Origin es un convención, no una arquitectura
3. clone, fetch, pull, push son 4 operaciones distintas

**Ejercicio: 03-remotes**

Antes del ejercicio:
- Mostrar `git remote -v`
- Explicar: "origin es solo un alias, como un contacto del teléfono"
- Demostrar fetch vs pull en vivo

Durante el ejercicio:
- Los participantes ejecutan setup.sh y obtienen ana/ + luis/ + origin/
- Simulan el flujo: Ana push → Luis pull → Luis push → Ana pull
- Tiempo: ~10 min

Punto clave a reforzar:
- `fetch` no modifica archivos. `pull` sí.
- Que los participantes ejecuten `cat agenda.txt` después de fetch (no cambió)
  y después de pull (sí cambió)

**Bonus GitHub:**
- Si hay tiempo e internet, ejecutar `configurar-github.sh`
- Si no, mencionar que el script está disponible para después del taller

---

## Bloque 4 — Ciclo diario y ramas (diapositivas 20-22)

**Conceptos a transmitir:**
1. Pull al empezar, push al terminar
2. Commits pequeños = divergencia pequeña = integración fácil
3. Una rama te deja trabajar con libertad sin bloquear a otros

**Ejercicio: 02-ramas**

Antes del ejercicio:
- Mostrar `git branch` y `git switch`
- Dibujar en pizarra: main apunta a B, ana apunta a C
- Enfatizar: "la rama no es una carpeta, es un marcador"

Durante el ejercicio:
- Crean rama `ana`, hacen commit, vuelven a main
- Verifican que main no tiene el cambio de ana
- Hacen otro commit en main para que las ramas diverjan
- Visualizan con `git log --oneline --graph --all`

Pregunta trampa después del ejercicio:
- "Si borro la rama ana, ¿pierdo los commits?" → No, solo pierdo el marcador
- Mostrar: `git branch -d ana` y luego `git log --all` (los commits siguen ahí)

---

## Bloque 5 — Integración (diapositivas 23-34)

**Conceptos a transmitir:**
1. Merge: conserva el encuentro de dos ramas (merge commit con dos padres)
2. Rebase: reescribe commits sobre otra base (historial lineal)
3. ff-only: avanza sin crear merge commit (baranda de seguridad)
4. Conflictos: Git no puede decidir por el equipo

**Ejercicio: 04-merge-rebase**

Antes del ejercicio:
- Mostrar en pizarra los tres grafos (merge, rebase, ff-only)
- Regla de oro: "no hagas rebase de una rama compartida"

Durante el ejercicio:
- Parte A (merge): unen feature en main, ven el merge commit
- Parte B (rebase): reacomodan mi-cambio sobre main
- Parte C (ff-only): avanzan main hasta adelante
- Fallo de ff-only: intentan ff-only con ramas divergentes (falla)

**Ejercicio: 05-conflictos**

Antes del ejercicio:
- Mostrar en vivo un conflicto y los marcadores `<<< === >>>`
- Explicar cada marcador
- Mostrar el flujo: leer → conversar → editar → comprobar → commit

Durante el ejercicio:
- Primero mergean ana (sin conflicto)
- Luego mergean luis (conflicto)
- Abren el archivo, leen marcadores, deciden, editan, add, commit
- Bonus: `git merge --abort`

---

## Bloque 6 — Laboratorio final (diapositivas 35-41)

**Conceptos a transmitir:**
- Integración de todo lo anterior
- Ciclo completo de colaboración

**Ejercicio: 06-laboratorio**

Estructura:
- 3 rondas progresivas
- Ronda 1: push/pull sin conflictos (Ana agrega ensalada)
- Ronda 2: push/pull sin conflictos (Luis reordena)
- Ronda 3: conflicto real (ambos cambian "Sopa")

Rol del facilitador:
- Anunciar cada ronda: "Ronda 1: Ana agrega ensalada"
- Dar 2 min por ronda
- En la ronda 3, dejar que los participantes experimenten el conflicto
- No resolver por ellos; preguntar: "¿Qué combinación representa al equipo?"

---

## Errores comunes y cómo resolverlos

| Error | Causa | Solución |
|-------|-------|----------|
| `fatal: not a git repository` | Estás fuera de la carpeta del repo | `cd taller-0X` |
| `fatal: refusing to merge unrelated histories` | Repos con historiales distintos | No debería pasar con setup.sh |
| `detached HEAD` | Hiciste checkout de un commit, no de una rama | `git switch main` |
| `Your branch is ahead of origin/main` | Tienes commits locales sin push | `git push` |
| `error: failed to push` | El remote tiene commits que no tienes | `git pull` primero |
| `CONFLICT` | Dos personas tocaron la misma zona | Seguir pasos del ejercicio 05 |

---

## Preguntas frecuentes de participantes

**"¿Cuándo uso merge y cuándo rebase?"**
→ Merge para ramas compartidas (conserva contexto). Rebase para limpiar tu rama local antes de compartirla.

**"¿Cada cuánto debo hacer push?"**
→ Cuando termina una unidad nuclear de trabajo. Si la unidad es chica (10-30 min), el push es frecuente.

**"¿Qué pasa si me equivoco y hago force push?"**
→ Reescribes el historial remoto. Si alguien ya hizo pull de los commits viejos, tendrá que reacomodar su trabajo. Por eso la regla es: nunca force push a ramas compartidas.

**"¿Puedo trabajar sin internet?"**
→ Sí. Todo menos push/pull funciona sin red. Puedes hacer commits, crear ramas, ver historial, etc.

---

## Checklist previa al taller

- [ ] Verificar que `bash setup-global.sh` pasa en una terminal limpia
- [ ] Probar cada `setup.sh` de la carpeta ejercicios/
- [ ] Tener las diapositivas abiertas (PDF o Slidev)
- [ ] Tener terminal lista para demostraciones en vivo
- [ ] Si hay proyector, ajustar tamaño de fuente de la terminal
- [ ] Confirmar que los participantes tienen Git instalado

## Después del taller

- [ ] Compartir el enlace al repositorio
- [ ] Recordar que `recursos/cheat-sheet.md` es su referencia rápida
- [ ] Sugerir que practiquen con sus propios proyectos
