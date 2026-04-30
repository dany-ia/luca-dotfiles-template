# Fase 3: Internship-ready

**Cuándo hacerla:** 2 a 3 meses antes de aplicar a tu primer internship.
**Tiempo:** Distribuido en varias sesiones a lo largo de 4 a 6 semanas.
**Te lleva de:** profesional con buen setup → candidato que destaca en entrevistas.

---

## El cambio de mentalidad

Las primeras 2 fases fueron sobre **tu setup**. Esta fase es sobre **tu
evidencia pública** de que sabes lo que haces.

La verdad simple: cuando apliques a Bain, Deloitte, KPMG, Tec Capital,
Femsa, Heineken, Banamex, Globant, lo que sea, va a haber 200+ aplicantes
con tu mismo CV. "LIT del Tec, 8.5 promedio, sabe Python y SQL".

Lo que te va a sacar del stack es:

1. **GitHub público con proyectos serios.** No tareas, proyectos.
2. **Una skill diferenciadora.** Algo que el LIT promedio NO tiene.
3. **Setup que se ve serio en screen-share.** Esto ya lo tienes desde Fase 1.
4. **Capacidad de hablar de tu código.** "Sabe Python" vs "puedo explicarte
   por qué usé scikit-learn aquí en lugar de statsmodels".

Vamos a construir las 4.

---

## Módulo A: Claude Code (programar con IA al nivel pro)

Tu papá lo usa todos los días. Es la herramienta de Anthropic para que los
desarrolladores trabajen con IA directamente desde la terminal, sabiendo el
contexto de tu proyecto.

### Instalar

```bash
brew install node
npm install -g @anthropic-ai/claude-code
claude --version
```

### Login

```bash
claude
```

Login con tu cuenta de Anthropic (la misma de claude.ai). Si tienes Claude
Pro o Max, las capacidades aumentan significativamente.

### Por qué esto te diferencia

Tus compañeros usan ChatGPT en navegador, copy-paste código. Tú vas a usar
Claude Code que **ve tu proyecto entero**, te ayuda a refactorizar,
encuentra bugs, propone mejoras arquitectónicas.

En entrevistas, cuando mencionas que usas Claude Code (no solo ChatGPT),
comunicas dos cosas:

1. Sabes de tooling reciente
2. Trabajas como ingeniero, no como estudiante copy-pasting

### Caso práctico

Toma uno de tus repos públicos (de Fase 2) y hazlo:

```bash
cd ~/Projects/analisis-inflacion-mexico-2024
claude
```

Pídele a Claude:

> "Revisa mi notebook principal y sugiéreme 3 mejoras que harían este
> análisis más profesional. Enfoque: legibilidad, robustez, y cómo se vería
> en un portfolio de internship."

Implementa las sugerencias. Commit y push. Tu repo mejora un nivel.

---

## Módulo B: Tu skill diferenciadora

Esto es lo más importante de toda la Fase 3. **Tienes que tener UNA cosa
que el LIT promedio no tiene.**

Opciones según tus intereses:

### Opción 1: Cloud certifications (más valor académico/corporativo)

| Certificación | Costo | Tiempo prep | Valor para internship |
|---|---|---|---|
| Google Cloud Digital Leader | $99 USD | 2 a 4 semanas | Alto, especialmente para BigQuery + analytics |
| AWS Cloud Practitioner | $100 USD | 3 a 4 semanas | Muy alto, AWS domina enterprise |
| Azure Fundamentals (AZ-900) | $99 USD | 3 a 4 semanas | Alto, mucha empresa Mexicana usa Azure |

Tu papá puede ayudarte a costear. Una cert reciente en tu CV pesa mucho más
que un examen del Tec.

### Opción 2: Especialización técnica (más valor para empresas tech)

Una de estas, no todas:

- **Modern Data Stack**: dbt + Snowflake + Airflow. Lo que usan startups serias.
- **MLOps básico**: Docker + MLflow + un modelo desplegado. Diferenciador
  grande.
- **Streaming**: Kafka básico + procesamiento real-time. Nicho pero altamente
  pagado.

### Opción 3: Domain expertise (más valor para consultoría)

Convertirte en el chavo del Tec que sabe de UNA industria específica con
datos:

- **Retail/CPG analytics**: usar datos públicos de INEGI ENIGH para entender
  consumo en México
- **Real estate**: scraping de Inmuebles24, modelo predictivo de precios
  CDMX/Monterrey
- **Sports analytics**: datos de Liga MX, modelos predictivos
- **Tu negocio familiar**: con permiso de tu papá, datos de Oceanic
  anonimizados

Cualquiera de las 3 opciones, **el output debe ser un repo público que
demuestre la skill**.

### Mi recomendación para LIT 4to sem

Combina opción 1 (cert) + opción 3 (domain). Algo así:

- 1 cert AWS o GCP en los próximos 3 meses
- 1 repo público de domain expertise (e.g., "Análisis del consumo en
  restaurantes de Riviera Maya post-pandemia con datos públicos de INEGI")

Eso es CV de internship-ready.

---

## Módulo C: Proyectos públicos serios

Tu GitHub al momento de aplicar internship debe tener:

| Tipo | Cuántos | Qué demuestra |
|---|---|---|
| Setup repos | 1 | luca-dotfiles, ya lo tienes |
| Tareas Tec adaptadas | 2 a 3 | Habilidad académica con presentación profesional |
| Proyectos personales | 2 a 3 | Iniciativa propia |
| Práctica técnica | 1 a 2 | sql-practice, leetcode-data, etc. |

### Plantilla de README profesional

Cada proyecto público debe tener un README que comunique en 30 segundos.
Toma esta plantilla:

```bash
cat > ~/Projects/luca-dotfiles/casos/README_TEMPLATE.md <<'EOF'
# [Nombre del proyecto]

> [Una línea: qué problema resuelve]

## TL;DR

[2 a 3 líneas. Si alguien solo lee esto, debe entender qué hiciste y por
qué importa.]

## Pregunta de negocio

[Qué pregunta concreta responde este análisis]

## Datos

- **Fuente:** [INEGI, Kaggle, etc.]
- **Periodo:** [enero 2020 - diciembre 2024]
- **Volumen:** [10K registros, 25 columnas]
- **Calidad:** [problemas, valores faltantes, supuestos]

## Stack

- Python 3.12 + pandas + scikit-learn
- PostgreSQL para queries
- Tableau para dashboard final

## Hallazgos principales

1. [Insight 1 con número concreto]
2. [Insight 2 con número concreto]
3. [Insight 3 con número concreto]

## Visualizaciones

[Embed de imagen o screenshot del dashboard]

## Cómo reproducir

```bash
git clone [url]
cd [proyecto]
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
jupyter lab notebooks/01_analisis.ipynb
```

## Limitaciones

[Qué NO hace este análisis. Honestidad intelectual.]

## Aprendizajes

[Qué aprendiste tú en el proceso. Esto humaniza el repo.]

---

Hecho por **Luca Villarreal** | LIT Tec de Monterrey | [LinkedIn](url) | [tu-correo]
EOF
```

Cada proyecto tuyo usa esta plantilla. Después de 5 proyectos así, tu
GitHub se ve serio en serio.

---

## Módulo D: Funciones zsh para velocidad

A estas alturas ya identificaste cosas que haces todos los días.
Automatízalas como funciones.

Agrega a tu zshrc:

```bash
# ============================================
# Funciones avanzadas
# ============================================

# Sincronizar dotfiles cross-Mac (si tienes 2 Macs)
dotsync() {
  cd ~/Projects/luca-dotfiles
  git pull
  source ~/.zshrc
  echo "Dotfiles sincronizados desde GitHub"
}

# Push rápido con mensaje
ship() {
  if [ -z "$1" ]; then
    echo "Uso: ship 'mensaje del commit'"
    return 1
  fi
  git add .
  git commit -m "$1"
  git push
}

# Crear notebook nuevo en proyecto actual
notebook() {
  local name="${1:-analysis_$(date +%Y%m%d)}"
  if [ ! -d "venv" ]; then
    echo "No hay venv. Activa uno primero o crea proyecto con new_bi_project."
    return 1
  fi
  source venv/bin/activate
  jupyter notebook "notebooks/${name}.ipynb" 2>/dev/null || jupyter notebook
}

# Stats rápidos de un CSV
csv-stats() {
  if [ -z "$1" ]; then
    echo "Uso: csv-stats <archivo.csv>"
    return 1
  fi
  python3 -c "
import pandas as pd
df = pd.read_csv('$1')
print(f'Shape: {df.shape}')
print(f'Columns: {list(df.columns)}')
print(f'Dtypes:')
print(df.dtypes)
print(f'Missing values:')
print(df.isnull().sum())
print(f'Sample:')
print(df.head())
"
}

# Buscar texto en todos los archivos del proyecto actual
findcode() {
  if [ -z "$1" ]; then
    echo "Uso: findcode 'texto a buscar'"
    return 1
  fi
  grep -r --include="*.py" --include="*.ipynb" --include="*.md" --include="*.sql" "$1" .
}
```

Recarga: `source ~/.zshrc`.

Ahora `ship "fix data cleaning"` reemplaza 3 comandos. `csv-stats data.csv`
te da resumen instantáneo. Estas son las cosas que un junior senior hace
sin pensar.

---

## Módulo E: Cross-Mac sync (si tienes o llegas a tener 2 Macs)

Si en el futuro tienes laptop personal + de trabajo, tu setup debe ser
idéntico en ambas. Tu papá tiene esto entre Mac Studio y MacBook Air M5.

En el segundo Mac:

```bash
# Bootstrap mínimo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clonar dotfiles
mkdir -p ~/Projects
cd ~/Projects
gh auth login   # autenticar
gh repo clone tu-usuario/luca-dotfiles
cd luca-dotfiles

# Replicar todo
brew bundle --file=./Brewfile
ln -sf $PWD/zshrc ~/.zshrc
mkdir -p ~/.config
ln -sf $PWD/starship.toml ~/.config/starship.toml

# iTerm2 prefs (si las versionaste)
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$PWD/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

15 minutos y tu segundo Mac es idéntico al primero. Esto es lo que hizo tu
papá la semana pasada con la M5.

---

## Módulo F: SSH y conexión a servidores

En internships reales, vas a conectarte a servidores remotos para acceder a
BDs, correr scripts, etc.

### Generar llave SSH

```bash
ssh-keygen -t ed25519 -C "tu-correo@ejemplo.com"
```

Acepta defaults. Pasa-frase guárdala en password manager.

### Agregar a GitHub

```bash
cat ~/.ssh/id_ed25519.pub
```

Copia el output. [github.com/settings/keys](https://github.com/settings/keys) → New SSH key → pega.

Cambia tus repos a SSH:

```bash
cd ~/Projects/luca-dotfiles
git remote set-url origin git@github.com:tu-usuario/luca-dotfiles.git
```

### Conectarte a servidores

```bash
ssh usuario@servidor.empresa.com
```

Cuando tengas acceso a un servidor real (en internship), vas a editarte un
`~/.ssh/config` para tener atajos:

```
Host empresa-staging
  HostName staging.empresa.com
  User luca.villarreal
  IdentityFile ~/.ssh/id_ed25519

Host empresa-prod
  HostName prod.empresa.com
  User luca.villarreal
  IdentityFile ~/.ssh/id_ed25519
```

Así solo escribes `ssh empresa-staging` y ya estás dentro.

---

## Módulo G: Docker (cuando lo necesites, no antes)

Docker es útil cuando empieces a trabajar con stacks complejos (BD + Python
+ Redis + lo que sea). Para tareas del Tec normales, NO lo necesitas.

Instálalo cuando un proyecto real lo demande:

```bash
brew install --cask docker
```

Curva de aprendizaje seria. Cuando llegue el momento, pídele a Claude Code
que te ayude:

```bash
cd ~/Projects/proyecto-complejo
claude
# "Configúrame un docker-compose con PostgreSQL 16 y un servicio Python con Jupyter"
```

---

## Módulo H: Tu LinkedIn alineado a tu GitHub

Esto es soft pero crítico. Tu LinkedIn debe reflejar lo que tu GitHub
demuestra.

### Cambios concretos en LinkedIn

1. **Headline**: "BI Analyst in training | LIT Tec de Monterrey | Python · SQL · Tableau"
2. **About**: 3 párrafos. Quién eres, qué estudias, qué proyectos has hecho
   (con links a tus repos públicos).
3. **Featured**: pinea tus 3 mejores repos de GitHub directamente.
4. **Projects**: cada repo público merece una entrada con link.
5. **Skills**: solo las que puedes demostrar con un repo. Si no, fuera.

### Qué NO poner en LinkedIn

- Cursos de Coursera/Udemy que solo viste por encima
- "Microsoft Office Expert" (todo el mundo lo pone, ya no diferencia)
- Skills sin evidencia (Python, R, etc. solo si tienes repos)

---

## Módulo I: Aprender continuamente

Esta es la skill que decide tu carrera larga. Recursos curados:

| Para | Recurso |
|---|---|
| Data analytics | [Towards Data Science](https://towardsdatascience.com), [Kaggle Learn](https://kaggle.com/learn) |
| SQL | [Mode SQL Tutorial](https://mode.com/sql-tutorial), [LeetCode SQL](https://leetcode.com/problemset/database) |
| Python serio | [Real Python](https://realpython.com), [Fluent Python](https://www.fluentpython.com) |
| R serio | [R for Data Science](https://r4ds.had.co.nz) |
| Cloud | [Google Cloud Skills Boost](https://cloudskillsboost.google), [AWS Skill Builder](https://skillbuilder.aws) |
| Career | [Pragmatic Engineer Newsletter](https://www.pragmaticengineer.com) |
| Tooling | [Awesome Shell](https://github.com/alebcay/awesome-shell), [Awesome Python](https://github.com/vinta/awesome-python) |

Suscríbete a 2 a 3, no a todos. Mejor profundo que ancho.

---

## Cierre de Fase 3

```bash
cd ~/Projects/luca-dotfiles
nano README.md
# Marca: - [x] Fase 3: Internship-ready
git add .
git commit -m "Fase 3 complete: internship-ready setup with public portfolio"
git push
```

---

## Auditoría final: ¿estás listo para internship?

Checklist honesto. Marca lo que ya tienes:

**Setup técnico:**
- [ ] Mac con Tokyo Night, Nerd Font, Starship, power tools
- [ ] Dotfiles versionados en repo público
- [ ] Workflow `new_bi_project` automatizado
- [ ] VS Code configurado con extensiones BI
- [ ] PostgreSQL local + Supabase o BigQuery cloud

**Portfolio público:**
- [ ] Al menos 4 repos públicos serios
- [ ] Cada repo con README profesional
- [ ] Al menos 1 proyecto con dashboard (Tableau o similar)
- [ ] Al menos 1 proyecto con datos en la nube

**Skills diferenciadoras:**
- [ ] 1 cert cloud reciente (AWS, GCP, o Azure) o en progreso
- [ ] Familiar con Claude Code u otro AI coding assistant
- [ ] LinkedIn alineado a GitHub

**Habilidades demostrables:**
- [ ] Puedo explicar cada decisión técnica de mis repos en una entrevista
- [ ] Puedo modificar un script de un repo en vivo durante una entrevista
- [ ] Tengo respuesta sólida a "Cuéntame de un proyecto del que te sientas orgulloso"

Si tienes 80%+ marcados, **estás listo para aplicar a internships en
empresas serias.**

---

## Una nota personal final

Luca, te voy a decir algo que tu papá probablemente no te ha dicho así de
directo:

El Tec te da credenciales. Pero las credenciales solas no consiguen los
mejores trabajos. Hay 50,000 LITs en México. Lo que separa a los que
trabajan en Bain/Globant/Femsa de los que trabajan en cualquier empresa
cualquiera, es **evidencia pública de calidad**.

Tu GitHub público, tus dotfiles, tus repos, tus certs, son esa evidencia.

Si llegaste hasta aquí en este manual y lo aplicaste, no eres "estudiante
de LIT". Eres "junior data analyst con 4 años de prep formal y portfolio
público". Es una diferencia de categoría.

Tu papá hizo cosas similares en su carrera (no con setup, era otra época,
pero con la misma lógica de evidenciar trabajo). Mira dónde está hoy. La
lógica funciona.

Ahora ve a romperla en tu primer internship. Estamos esperando ver dónde
caes.

---

Errores comunes: [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md).

Repo de tu papá para inspiración: `dany-ia/danvilx-dotfiles`.
