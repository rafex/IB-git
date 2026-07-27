# Git Cheat Sheet — Taller Git para colaborar

## Los 4 lugares

| Lugar | Comando clave | ¿Qué hay ahí? |
|-------|--------------|----------------|
| Working tree | editas archivos | Tus cambios sin guardar |
| Staging area | `git add` | Lo que elegiste preparar |
| Repo local | `git commit` | Historial completo en tu equipo |
| Remote | `git push` / `git fetch` | Otra copia del historial |

## Flujo diario

```bash
git pull                  # traer cambios recientes
# ... editas archivos ...
git status                # ver qué cambió
git add archivo.txt       # preparar cambios
git commit -m "mensaje"   # guardar decisión
git push                  # compartir con el equipo
```

## Commits

```bash
git log                   # ver historial
git log --oneline         # versión compacta
git log --graph --all     # ver ramas como grafo
git show HEAD             # ver el último commit
git show <hash>           # ver un commit específico
```

## Ramas

```bash
git branch                # listar ramas locales
git branch -a             # listar todas (locales + remotas)
git branch <nombre>       # crear rama
git switch <nombre>       # moverte a una rama
git switch -c <nombre>    # crear y moverte
git checkout <nombre>     # (alternativa legacy) moverte a una rama
```

## Remotos

```bash
git remote -v             # listar remotos configurados
git clone <url>           # copiar repo con historial
git fetch                 # traer referencias sin modificar archivos
git pull                  # fetch + integrar en rama actual
git push                  # publicar commits locales
git push -u origin main   # push y vincular rama con remote
```

## Integración

```bash
git merge <rama>          # unir rama en la actual
git merge --ff-only <rama> # solo si no hay bifurcación
git rebase <rama>         # reacomodar commits sobre otra rama
git rebase -i <ref>       # rebase interactivo (squash, reorder)
```

## Conflictos

```bash
# Cuando git merge falla por conflicto:
git status                # ver archivos en conflicto
# ... editas el archivo, quitas los marcadores <<< === >>> ...
git add archivo.txt       # marcar como resuelto
git commit                # completar el merge
# O si quieres cancelar:
git merge --abort
```

## Inspección

```bash
git diff                  # cambios no preparados (working tree vs staging)
git diff --staged         # cambios preparados (staging vs último commit)
git diff main..feature    # diferencias entre dos ramas
git log -p                # historial con diffs
git blame archivo.txt     # quién tocó cada línea
```

## Deshacer

```bash
git restore archivo.txt   # descartar cambios en working tree
git restore --staged archivo.txt  # sacar del staging sin perder cambios
git reset --soft HEAD~1   # deshacer último commit (cambios vuelven a staging)
git revert <hash>         # crear commit que revierte otro commit
```
