# Git para colaborar — Taller práctico

Curso básico de Git · ejercicios con archivos de texto

## Requisitos

- Git instalado (2.x o superior)
- Terminal (bash, zsh, o similar)
- Editor de texto

Verifica tu instalación:

```bash
git --version
bash --version
```

## Arranque rápido

```bash
# 1. Clona este repositorio
git clone <url-de-este-repo> git-taller
cd git-taller

# 2. Ejecuta el setup global (verifica prerequisitos)
bash setup-global.sh

# 3. Ve a la carpeta de ejercicios y empieza por el primero
cd ejercicios/01-commits
bash setup.sh
```

## Mapa de ejercicios

| # | Ejercicio | Concepto | Archivo |
|---|-----------|----------|---------|
| 01 | Commits | Commits como instantáneas, mensajes claros | `agenda.txt` |
| 02 | Ramas | Crear y trabajar con ramas | `agenda.txt` |
| 03 | Remotes | clone, fetch, pull, push, bare repos | — |
| 04 | Merge & Rebase | merge, rebase, ff-only | `agenda.txt` |
| 05 | Conflictos | Crear, leer y resolver conflictos | `acuerdos.txt` |
| 06 | Laboratorio | Trabajo paralelo Ana + Luis | `menu.txt` |

Cada carpeta contiene:

- `README.md` — instrucciones paso a paso
- `setup.sh` — prepara el entorno del ejercicio
- Archivos de texto — el contenido con el que trabajarás

## Estructura del repositorio

```
.
├── README.md                 # Esta guía
├── setup-global.sh           # Verifica prerequisitos
├── GUIA-FACILITADOR.md       # Guía para quien imparte el taller
├── ejercicios/               # Los ejercicios: uno por carpeta
│   ├── 01-commits/
│   ├── 02-ramas/
│   ├── 03-remotes/
│   ├── 04-merge-rebase/
│   ├── 05-conflictos/
│   └── 06-laboratorio/
├── soluciones/               # Estado esperado de cada ejercicio
└── recursos/
    ├── cheat-sheet.md        # Comandos rápidos
    └── modelo-mental.md      # Los 4 lugares y el flujo
```

## Niveles de remotos

Cada ejercicio que involucra remotos soporta tres modos:

1. **Local (bare)** — repositorios bare locales, sin internet
2. **GitHub** — repos reales en GitHub
3. **Terceros** — cualquier otro remote (GitLab, Bitbucket, etc.)

Para cambiar de modo, edita la variable `REMOTE_URL` en el `setup.sh` correspondiente.
