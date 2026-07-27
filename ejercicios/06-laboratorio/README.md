# 06 — Laboratorio: Ana y Luis colaboran

**Concepto:** Ciclo completo de colaboración con archivos de texto.

**Duración:** ~15 minutos

## Objetivo

Simular un día de trabajo colaborativo: dos personas editan `menu.txt`
en paralelo, integran sus cambios y resuelven un posible conflicto.

## Instrucciones

Ejecuta el setup:

```bash
bash setup.sh
```

Esto crea `taller-06/` con:
- `origin/` — repositorio bare (simula GitHub)
- `ana/` — clon de Ana
- `luis/` — clon de Luis

Ambos empiezan con el mismo `menu.txt`:

```
1. Sopa
2. Pan
```

### Ronda 1 — Ana agrega una opción

```bash
cd taller-06/ana

# Edita menu.txt: agrega "3. Ensalada"
git add menu.txt
git commit -m "agrega ensalada al menú"
git push
```

```bash
cd taller-06/luis
git pull
cat menu.txt          # Luis ya ve la ensalada de Ana
```

### Ronda 2 — Luis corrige el orden

```bash
cd taller-06/luis

# Edita menu.txt: mueve Pan al final
# Debería quedar:
# 1. Sopa
# 2. Ensalada
# 3. Pan

git add menu.txt
git commit -m "reordena menú: pan al final"
git push
```

```bash
cd taller-06/ana
git pull
cat menu.txt          # Ana ya ve el nuevo orden
```

### Ronda 3 — Ambos editan la misma zona (conflicto)

```bash
cd taller-06/ana

# Edita menu.txt: cambia "Sopa" por "Sopa del día"
git add menu.txt
git commit -m "especifica sopa del día"
git push
```

```bash
cd taller-06/luis

# Antes de hacer pull, edita menu.txt:
# Cambia "Sopa" por "Sopa de verduras"

git add menu.txt
git commit -m "especifica sopa de verduras"

git pull
# ¡Conflicto! Ambos tocaron la misma línea.
```

Luis debe resolver el conflicto. Abre `menu.txt`:

```
<<<<<<< HEAD
1. Sopa de verduras
=======
1. Sopa del día
>>>>>>> ...
2. Ensalada
3. Pan
```

Luis decide: conserva "Sopa de verduras" (su versión). Edita, quita los marcadores, y:

```bash
git add menu.txt
git commit -m "resuelve: conserva sopa de verduras"
git push
```

```bash
cd taller-06/ana
git pull
cat menu.txt          # Ana ve la decisión de Luis
```

## Reflexión final

1. ¿En qué momento apareció cada cambio en el remote?
2. ¿Qué hubiera pasado si Ana no hubiera hecho push en la ronda 3?
3. ¿Cómo cambiaría el ejercicio si hubieran esperado al viernes para integrar?

## Reglas del taller

| Regla | Por qué |
|-------|---------|
| Commits pequeños y frecuentes | El auto-merge funciona mejor con diferencias chicas |
| Pull al empezar, push al terminar | Minimiza divergencia entre ramas |
| Conversar los conflictos | Git integra texto; el equipo integra decisiones |
| No hacer push de trabajo roto | Compartir no significa publicar cualquier cosa |

## Verifica tu resultado

Compara con `../../soluciones/06-laboratorio/`.
