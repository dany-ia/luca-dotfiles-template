# Fase 1: Profesionalizar lo que ya tienes

**Tiempo:** 2 a 3 horas en una sola sesión.
**Asume:** ya programas Python, has usado Git, tienes cuenta de GitHub, sabes qué es un notebook.
**Te lleva de:** setup default amateur → setup que se ve y funciona como senior.

---

## Empecemos por un diagnóstico honesto

Antes de instalar nada, vamos a auditar tu setup actual. Abre tu terminal (la que sea) y corre estos comandos. **Anota mentalmente lo que NO tienes:**

```bash
brew --version           # ¿Tienes Homebrew?
git config user.name     # ¿Git está configurado con tu identidad real?
gh --version             # ¿Tienes GitHub CLI?
echo $SHELL              # ¿Es zsh? (debería ser /bin/zsh)
ls ~/.zshrc              # ¿Tienes un zshrc? ¿Qué tan corto es?
which python3            # ¿Qué Python usas?
ls ~/Projects 2>/dev/null # ¿Tienes un folder dedicado a proyectos?
```

Resultado típico de un estudiante de mitad de carrera:

| Resultado | Qué significa | Dónde estás |
|---|---|---|
| Brew sí, gh no | Sabes lo básico pero no usas terminal pro | Típico LIT 4to sem |
| zshrc default vacío | No has personalizado nada | 95% de compañeros |
| Python desde sistema o Anaconda | Te falta workflow de venvs por proyecto | Riesgo de conflictos |
| Sin folder Projects | Tareas dispersas en Desktop o Downloads | El síntoma más claro de "amateur" |

No hay vergüenza en estar ahí. Lo importante es dónde vas a estar después de
esta fase.

---

## Por qué esta fase es diferente

No te voy a enseñar a usar Git ni a instalar Python. Eso ya lo sabes.

Te voy a enseñar a:

1. **Hacer que tu Mac se vea profesional** (cuando hagas screen-share, importa)
2. **Versionar tu personalización** (tu setup vive en GitHub, no en tu Mac)
3. **Acelerar tu workflow diario** con power tools que tus compañeros no usan
4. **Crear estructura** para que tu trabajo académico se vea como el de un
   profesional

---

## Paso 1: iTerm2 + Tokyo Night (estética profesional)

Si todavía usas la Terminal default de macOS, hoy cambia.

```bash
brew install --cask iterm2
```

Abre iTerm2 desde Spotlight. **Cierra la Terminal default y no la vuelvas a
abrir.** Si te ves usando ambas, te pierdes en cuál configuraste qué.

### Tema Tokyo Night

```bash
cd ~/Downloads
curl -fLO "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Tokyo%20Night.itermcolors"
open "Tokyo Night.itermcolors"
```

El `open` aplica el tema directamente.

Para activarlo en tu perfil:

1. iTerm2 → `Cmd+,` → Profiles → Default → Colors
2. Color Presets... → Tokyo Night

### Fuente Nerd Font (la que usan los profesionales)

```bash
cd ~/Library/Fonts
curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fLo "MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fLo "MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fLo "MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
```

iTerm2 Preferences → Profiles → Default → Text → Font: **MesloLGS NF Regular 13pt**.

**Cmd+Q en iTerm2** y reábrelo. Tu terminal ya se ve profesional.

### Por qué esto importa para internships

Cuando hagas screen-share en una entrevista técnica, los reclutadores notan:

- Si tu terminal se ve cuidada o default
- Si tienes tema oscuro (estándar profesional) o blanco (estándar estudiante)
- Si la fuente tiene iconos y se lee fácil, o es la system default

No es vanidad. Es la primera impresión visual de que sabes lo que haces.

---

## Paso 2: Power tools que tus compañeros no tienen

Estos 6 son los que te van a diferenciar inmediatamente:

```bash
brew install starship atuin fzf zoxide bat eza gh
```

| Tool | Qué hace | Por qué importa |
|---|---|---|
| **starship** | Prompt con info de Git, Python version, tiempo de comando | Profesional. Default es feo. |
| **atuin** | Historial de comandos buscable con Ctrl+R | Productividad 10x cuando tengas cientos de comandos |
| **fzf** | Búsqueda difusa interactiva | Encuentras archivos sin recordar el nombre exacto |
| **zoxide** | `cd` que aprende. Saltas a directorios escribiendo fragmentos | Reemplaza `cd ~/Projects/long/path/...` con `z proj` |
| **bat** | `cat` con sintaxis coloreada | Vas a leer código todo el tiempo. Que se vea legible. |
| **eza** | `ls` con iconos y colores | Lo mismo que bat pero para listings |
| **gh** | GitHub desde terminal | Crear repos, abrir PRs, ver issues sin salir de iTerm2 |

Si ya tenías algunos, brew los detecta y no los reinstala.

---

## Paso 3: Crear tu repo `luca-dotfiles`

Aquí empieza lo serio. Vas a versionar tu configuración personal.

```bash
gh auth login   # si no estás autenticado todavía
mkdir -p ~/Projects
cd ~/Projects
gh repo create luca-dotfiles --public --description "Mi setup profesional de Mac. Configuración versionada para internship-ready BI workflows." --clone
cd luca-dotfiles
```

**Importante: lo creamos PÚBLICO, no privado.**

Razón: este repo es parte de tu portfolio. Cuando un reclutador vea tu
GitHub, este repo le comunica "este chavo profesionaliza su setup, versiona
su trabajo, escribe documentación". Es metacomunicación potente.

Si te incomoda lo público ahora, puedes dejarlo privado y hacerlo público
en Fase 3 cuando esté pulido. Pero el plan es que sea público.

---

## Paso 4: Configurar tu zshrc (versionado en el repo)

```bash
cd ~/Projects/luca-dotfiles

cat > zshrc <<'EOF'
# Mi configuración de shell
# Versionada en luca-dotfiles
# Stack BI: Python, R, SQL, Tableau

# ============================================
# Homebrew
# ============================================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ============================================
# Path
# ============================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# ============================================
# Editor
# ============================================
export EDITOR="code"
export VISUAL="code"

# ============================================
# Aliases productivos
# ============================================
# Listings con iconos
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --level=2 --icons"

# Cat con colores
alias cat="bat --paging=never"

# Git workflows
alias g="git"
alias gs="git status -sb"
alias gp="git push"
alias gpl="git pull"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias gaa="git add ."
alias gd="git diff"
alias glog="git log --oneline --graph --decorate -20"

# Navegación rápida
alias proj="cd ~/Projects"
alias dotfiles="cd ~/Projects/luca-dotfiles"

# Python venvs (workflow profesional)
alias venv-create="python3 -m venv venv && source venv/bin/activate && pip install --upgrade pip"
alias venv-on="source venv/bin/activate"
alias venv-off="deactivate"

# GitHub workflows
alias ghopen="gh repo view --web"
alias ghpr="gh pr create --web"

# ============================================
# Power tools init
# ============================================
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# ============================================
# Mensaje minimalista al abrir
# ============================================
echo "$(date '+%a %d %b, %H:%M') | $(uname -m)"
EOF

# Symlink al home
ln -sf ~/Projects/luca-dotfiles/zshrc ~/.zshrc
```

**Por qué symlink y no copia:**

Tu `~/.zshrc` es solo una flecha que apunta al archivo en tu repo. Cualquier
cambio que edites se versiona automáticamente. Cualquier `git pull` te trae
cambios al sistema sin pasos extra.

Es un patrón que usan los profesionales y que tus compañeros no usan. Tu
papá lo hace así.

---

## Paso 5: Configurar Starship con Tokyo Night

```bash
cd ~/Projects/luca-dotfiles

cat > starship.toml <<'EOF'
# Starship prompt - Tokyo Night
# Versionado en luca-dotfiles

format = """
[](#7AA2F7)\
$directory\
[](fg:#7AA2F7 bg:#9ECE6A)\
$git_branch\
$git_status\
[](fg:#9ECE6A bg:#E0AF68)\
$python\
$nodejs\
$rust\
[](fg:#E0AF68 bg:#F7768E)\
$cmd_duration\
[ ](fg:#F7768E)\
$character"""

[directory]
style = "fg:#1A1B26 bg:#7AA2F7 bold"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = " "
"Downloads" = " "
"Projects" = " "

[git_branch]
symbol = ""
style = "fg:#1A1B26 bg:#9ECE6A"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "fg:#1A1B26 bg:#9ECE6A"
format = '[$all_status$ahead_behind ]($style)'

[python]
symbol = ""
style = "fg:#1A1B26 bg:#E0AF68"
format = '[ $symbol $version ]($style)'

[nodejs]
symbol = ""
style = "fg:#1A1B26 bg:#E0AF68"
format = '[ $symbol $version ]($style)'

[rust]
symbol = ""
style = "fg:#1A1B26 bg:#E0AF68"
format = '[ $symbol $version ]($style)'

[cmd_duration]
min_time = 500
style = "fg:#1A1B26 bg:#F7768E"
format = '[  $duration ]($style)'

[character]
success_symbol = "[➜](bold #9ECE6A)"
error_symbol = "[➜](bold #F7768E)"
EOF

mkdir -p ~/.config
ln -sf ~/Projects/luca-dotfiles/starship.toml ~/.config/starship.toml

source ~/.zshrc
```

Tu prompt ahora se ve así: `[carpeta]  [rama git]  [versión python]  [tiempo del comando]`. Cada segmento con su color de Tokyo Night.

---

## Paso 6: Atuin (historial sincronizado)

Atuin reemplaza tu historial con uno mucho más potente. Si en el futuro
tienes un segundo Mac (laptop personal + de trabajo), tu historial se
sincroniza entre los dos.

```bash
atuin register -u luca -e tu-correo@ejemplo.com
```

Te genera password y encryption key. **Guarda ambas en tu password manager
(1Password, Bitwarden, o el llavero de macOS) AHORA.** No "después". Ahora.

Si no tienes password manager, este es buen momento para empezar a usar uno.
1Password Family ($60 USD/año) o Bitwarden (gratis) son los buenos.

```bash
source ~/.zshrc
```

Prueba: presiona `Ctrl+R`. Se abre buscador interactivo de tu historial.
Empieza a escribir y filtras. Esta es una de las productividad-multiplicadoras
más grandes.

---

## Paso 7: Estructura `~/Projects` profesional

Aquí es donde la mayoría de tus compañeros la riegan. Tienen tareas
dispersas en Desktop, Downloads, iCloud, Drive. Imposible mostrar trabajo a
un reclutador.

Tu `~/Projects` va a ser tu single source of truth.

```bash
mkdir -p ~/Projects/{tec,personal,sandbox,clients}
cd ~/Projects
ls -la
```

| Folder | Para qué |
|---|---|
| `tec/` | Tareas y proyectos del Tec, organizados por materia |
| `personal/` | Tus side projects, experimentos públicos |
| `sandbox/` | Pruebas rápidas, scripts desechables |
| `clients/` | Si llegas a tener clientes freelance, aquí |

Estructura recomendada para `tec/`:

```bash
cd ~/Projects/tec
mkdir -p sem4 sem5
cd sem4
mkdir -p analitica-de-datos econometria estadistica-aplicada bd-avanzadas
```

(Ajusta los nombres a tus materias reales del 4to semestre.)

A partir de ahora, cuando empieces una tarea o proyecto, **vive aquí**. No
en Desktop. No en Downloads.

---

## Paso 8: Versionar lo que ya tienes a tu repo

Vamos a cerrar Fase 1 con un commit serio.

```bash
cd ~/Projects/luca-dotfiles

cat > README.md <<'EOF'
# luca-dotfiles

Mi configuración personal de Mac.

Stack: Python (BI), R, SQL, Tableau, PostgreSQL, Jupyter.

## Setup

```bash
git clone https://github.com/tu-usuario/luca-dotfiles.git ~/Projects/luca-dotfiles
cd ~/Projects/luca-dotfiles
ln -sf $PWD/zshrc ~/.zshrc
ln -sf $PWD/starship.toml ~/.config/starship.toml
brew bundle --file=./Brewfile  # Fase 2
```

## Status

- [x] Fase 1: Setup profesional
- [ ] Fase 2: Workflows de internship
- [ ] Fase 3: Internship-ready

## Tools

| Categoría | Tools |
|---|---|
| Shell | zsh + Starship + Atuin + zoxide + fzf |
| Visual | iTerm2 + Tokyo Night + MesloLGS NF |
| Listings | eza (ls), bat (cat) |
| Git | git, gh CLI |

## Stack BI (próximamente en Fase 2)

R + RStudio, PostgreSQL local, Jupyter Lab, Python con venvs por proyecto.

---

LIT Tec de Monterrey - Generación en curso.
EOF

cat > .gitignore <<'EOF'
.DS_Store
.AppleDouble
.LSOverride

.vscode/
.idea/

__pycache__/
*.pyc
.venv/
venv/
.ipynb_checkpoints/

.env
*.key
*.pem
secrets/
EOF

git add .
git commit -m "Fase 1 complete: pro shell setup with Tokyo Night, power tools, structured Projects/"
git push
```

**Verifica:**

```bash
gh repo view --web
```

Tu repo en GitHub ya muestra: zshrc estructurado, starship.toml profesional,
README claro. Esto es lo que un reclutador ve si llega a tu perfil.

---

## Cierre de Fase 1

Lo que tienes ahora vs hace 3 horas:

| Antes | Ahora |
|---|---|
| Terminal default macOS | iTerm2 + Tokyo Night + MesloLGS NF |
| Comandos sin historial buscable | Atuin con Ctrl+R mágico |
| `cd /largo/path` | `z proj` (zoxide) |
| `ls`, `cat` defaults | eza con iconos, bat con sintaxis |
| Tareas dispersas | `~/Projects` estructurado |
| Sin dotfiles | Repo público `luca-dotfiles` versionado |

Esto es **el setup que tienen los analistas de datos en Bain, Globant, KPMG**.
Lo construiste en 3 horas.

---

## Qué NO hacer en las próximas 2 a 3 semanas

1. **No saltes a Fase 2 todavía.** Usa este setup todos los días. Fórzate a
   abrir iTerm2 en lugar de Terminal. Fórzate a meter tareas en
   `~/Projects/tec/sem4/`. Hasta que sea automático, no avances.

2. **No personalices todavía.** Te van a dar ganas de cambiar colores,
   agregar plugins, etc. No lo hagas. Primero internaliza lo que tienes. La
   personalización viene en Fase 2.

3. **No instales más tools por instalar.** Cada tool nueva debe resolver un
   problema real que tengas. "Está de moda" no es razón.

---

## Una nota personal

Luca, si llegaste hasta aquí en una sola sesión, ya hiciste lo que el 80%
de tus compañeros nunca van a hacer. No exagero.

La diferencia entre un estudiante de LIT y un junior contratable no es más
conocimiento técnico. Es **disciplina de workflow**. Lo que acabas de
configurar es la base de esa disciplina.

Sigue. Vale la pena.

---

Continúa con: [`FASE_2_WORKFLOWS.md`](FASE_2_WORKFLOWS.md) cuando hayas
usado este setup por al menos 2 semanas a diario.

Si algo se rompió en el proceso: [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md).
