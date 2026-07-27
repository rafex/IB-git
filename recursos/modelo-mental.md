# Modelo mental: los 4 lugares de Git

```
┌─────────────────┐     git add     ┌─────────────────┐    git commit    ┌─────────────────┐     git push      ┌─────────────────┐
│                 │ ───────────────→ │                 │ ────────────────→ │                 │ ─────────────────→ │                 │
│  Working tree   │                 │  Staging area   │                   │  Repo local     │                    │  Remote         │
│  (tus archivos)  │ ←─────────────── │  (preparado)   │ ←──────────────── │  (historial)    │ ←───────────────── │  (origin)        │
│                 │  git restore    │                 │  git reset HEAD   │                 │    git fetch        │                 │
└─────────────────┘                 └─────────────────┘                   └─────────────────┘                    └─────────────────┘
```

## Cada lugar tiene un propósito

| Lugar | ¿Qué contiene? | ¿Dónde está? | Comando de entrada |
|-------|---------------|-------------|-------------------|
| **Working tree** | Archivos que editas | Tu disco local | Editas con tu editor |
| **Staging area** | Lo que elegiste para el próximo commit | `.git/index` | `git add` |
| **Repo local** | Todo el historial de commits | `.git/` | `git commit` |
| **Remote** | Otra copia nombrada del historial | Otro equipo/servidor | `git push` |

## Regla para no perderse

> `git status` siempre te dice en qué lugar estás parado respecto a cada uno.

```bash
$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:    ← working tree tiene cambios
  modified:   agenda.txt

Untracked files:                   ← working tree tiene archivos nuevos
  notas.txt
```

## El grafo de commits

```
A ── B ── C ── D    main
      \
       E ── F        feature
```

- Cada letra es un commit (un estado del proyecto)
- `main` y `feature` son ramas (marcadores que apuntan a commits)
- El grafo es el historial real; las ramas solo son etiquetas móviles

## Preguntas para orientarte

1. ¿Dónde está mi cambio ahora? → `git status`
2. ¿De dónde viene este commit? → `git log`
3. ¿Quién más tocó esta línea? → `git blame`
4. ¿Qué hay en el remote que yo no tengo? → `git fetch && git log origin/main..main`
5. ¿Qué tengo yo que el remote no tiene? → `git log main..origin/main`
