# Fase 2: Workflows de internship

**Cuándo hacerla:** Después de 2 a 3 semanas usando Fase 1 todos los días.
**Tiempo:** 1 a 2 horas, idealmente en 2 sesiones.
**Te lleva de:** setup pro → sabes trabajar como un profesional, no como un estudiante.

---

## La diferencia que importa

Tus compañeros del Tec entregan tareas así:

```
~/Desktop/tarea_economia_v2_FINAL_corregida.ipynb
```

Los profesionales entregan trabajo así:

```
~/Projects/tec/sem4/econometria/regresion-lineal-mexico-2024/
├── README.md           ← Qué es, cómo correr, conclusiones
├── data/raw/           ← Datasets originales sin tocar
├── data/processed/     ← Datos limpios listos para modelar
├── notebooks/          ← Análisis exploratorio
├── src/                ← Scripts reutilizables
├── reports/            ← Outputs finales (PDF, dashboards)
├── requirements.txt    ← Para que cualquiera pueda reproducirlo
└── .gitignore
```

**Misma tarea. Diferente nivel de profesionalismo.**

Esta fase te enseña a trabajar así en automático. No es para que armes la
estructura cada vez. Es para que tengas plantillas y comandos que la generan
en segundos.

---

## Módulo A: Stack BI completo y aislado

### El problema que vas a resolver

Probablemente ahora instalas paqueterías de Python globalmente (con `pip
install pandas` directo). Eso funciona... hasta que un proyecto necesita
pandas 1.5 y otro pandas 2.1 y se rompen entre sí.

La solución profesional son **virtual environments por proyecto**. Cada
proyecto tiene su propio Python aislado.

### Instalar el stack

```bash
brew install r postgresql@16 jupyterlab
brew install --cask rstudio visual-studio-code
```

Esto puede tardar 10 a 15 min. Aprovecha para revisar la fase entera.

### Activar PostgreSQL

```bash
brew services start postgresql@16
createdb luca_test
psql luca_test -c "SELECT version();"
```

PostgreSQL local ya jala. Ahora puedes practicar SQL real (no Excel
disfrazado).

---

## Módulo B: Workflow de proyecto profesional

Vamos a crear una función que automatiza la estructura profesional. Una sola
vez la configuras, la usas siempre.

Edita tu zshrc:

```bash
cd ~/Projects/luca-dotfiles
nano zshrc
```

Agrega al final, **antes** del `echo` de bienvenida:

```bash
# ============================================
# Funciones BI profesionales
# ============================================

# Crear proyecto Python con estructura BI completa
new_bi_project() {
  if [ -z "$1" ]; then
    echo "Uso: new_bi_project <nombre>"
    echo "Ejemplo: new_bi_project ventas-walmart-mexico"
    return 1
  fi

  cd ~/Projects
  mkdir -p "$1"/{data/{raw,processed},notebooks,src,reports,docs}
  cd "$1"

  # Virtual environment
  python3 -m venv venv
  source venv/bin/activate
  pip install --upgrade pip --quiet

  # Stack BI estándar
  cat > requirements.txt <<EOF
pandas
numpy
matplotlib
seaborn
jupyter
scikit-learn
sqlalchemy
psycopg2-binary
python-dotenv
EOF
  pip install -r requirements.txt --quiet

  # README profesional
  cat > README.md <<EOF
# $1

## Objetivo

[Qué pregunta de negocio responde este proyecto]

## Datos

- Fuente:
- Periodo:
- Volumen:

## Stack

- Python 3.12 + pandas + scikit-learn
- PostgreSQL para queries
- Jupyter para exploración

## Setup

\`\`\`bash
git clone <url>
cd $1
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
jupyter lab
\`\`\`

## Estructura

| Folder | Qué tiene |
|---|---|
| data/raw | Datasets originales sin modificar |
| data/processed | Datos limpios y transformados |
| notebooks | Análisis exploratorio y modelado |
| src | Scripts reutilizables (funciones, ETL) |
| reports | Outputs finales (PDF, presentaciones) |

## Resultados

[Conclusiones y findings principales]

---

Hecho por Luca Villarreal | LIT Tec de Monterrey
EOF

  # Gitignore profesional
  cat > .gitignore <<EOF
# Python
venv/
__pycache__/
*.pyc
.ipynb_checkpoints/

# Data (no subir datasets pesados a Git)
data/raw/*
data/processed/*
!data/raw/.gitkeep
!data/processed/.gitkeep

# Secrets
.env
*.key

# OS
.DS_Store
EOF

  # Placeholders para Git
  touch data/raw/.gitkeep data/processed/.gitkeep

  # Inicializar Git
  git init --quiet
  git add .
  git commit -m "Initial commit: project structure" --quiet

  echo ""
  echo "Proyecto $1 listo en ~/Projects/$1"
  echo ""
  echo "Estructura:"
  ls -la
  echo ""
  echo "Para empezar:"
  echo "  cd ~/Projects/$1"
  echo "  source venv/bin/activate"
  echo "  jupyter lab"
}

# Activar venv del directorio actual
venv() {
  if [ -d "venv" ]; then
    source venv/bin/activate
    echo "venv activado: $(which python)"
  else
    echo "No hay venv en este directorio. Crear con: python3 -m venv venv"
    return 1
  fi
}

# Publicar proyecto a GitHub
publish() {
  local visibility="${1:-private}"
  if [ ! -d ".git" ]; then
    echo "No estás en un repo git. Inicializa con git init primero."
    return 1
  fi
  local name=$(basename $PWD)
  echo "Publicando $name como $visibility en GitHub..."
  gh repo create "$name" --"$visibility" --source=. --remote=origin --push
  gh repo view --web
}
```

Guarda. Recarga:

```bash
source ~/.zshrc
```

### Probar el workflow

Imagina que tienes una tarea de Econometría de regresión lineal con datos
de salarios:

```bash
new_bi_project regresion-salarios-mexico
```

En segundos tienes:
- Folder estructurado
- Virtual environment con stack BI
- README plantilla profesional
- .gitignore correcto
- Git inicializado con primer commit

Para empezar a trabajar:

```bash
cd ~/Projects/regresion-salarios-mexico
venv
jupyter lab
```

Cuando termines y quieras versionarlo:

```bash
publish private    # o publish public si lo quieres en portfolio
```

**Esto es lo que separa a un junior contratable de un estudiante.** Tus
compañeros pelean con setup cada vez. Tú lo automatizaste.

---

## Módulo C: VS Code para BI

VS Code es el editor más usado en el mundo profesional. Configurarlo bien.

### Extensiones esenciales

Abre VS Code (`code .` desde terminal) e instala (Cmd+Shift+X):

| Extensión | Para qué |
|---|---|
| Python | Soporte completo de Python |
| Jupyter | Notebooks dentro de VS Code |
| R | Si vas a usar R aquí (RStudio sigue siendo mejor para R puro) |
| SQLTools | Conectarte a PostgreSQL, MySQL, BigQuery |
| GitLens | Vista avanzada de Git e historial |
| Tokyo Night | Tema visual consistente |
| Better Comments | Comentarios con colores |
| Path Intellisense | Autocompletar paths de archivos |
| Rainbow CSV | Ver CSVs con columnas coloreadas |

### Configurar tema

Cmd+K Cmd+T → "Tokyo Night" → selecciona.

Tu VS Code, iTerm2 y Starship ahora todos usan la misma paleta. Cuando hagas
screen-share, todo se ve coherente y profesional.

### Settings recomendados

Cmd+, abre settings. Busca y ajusta:

- `Editor: Font Family`: `MesloLGS NF, Menlo, monospace`
- `Editor: Font Size`: 14
- `Workbench: Color Theme`: Tokyo Night
- `Files: Auto Save`: `afterDelay`
- `Editor: Format On Save`: true

---

## Módulo D: GitHub portfolio público

Aquí es donde te diferencias del 95%.

### Hacer tu repo `luca-dotfiles` público (si no lo es ya)

```bash
cd ~/Projects/luca-dotfiles
gh repo edit --visibility public
```

Si te incomoda, mantenlo privado. Pero el plan es portfolio.

### Tu primer proyecto BI público

Toma una tarea reciente que ya hayas hecho en clase. NO una con datos
confidenciales del Tec o de un cliente. Algo con datos públicos (INEGI,
World Bank, Kaggle, datos.gob.mx).

```bash
new_bi_project analisis-inflacion-mexico-2024
cd ~/Projects/analisis-inflacion-mexico-2024
venv
```

Trabaja el análisis. Cuando esté listo:

1. Mejora el README con resultados, gráficas, conclusiones
2. Sube los notebooks limpios a `notebooks/`
3. Si los datos son de fuente pública, agrega un script en `src/` que los
   descarga (así cualquiera puede reproducir)

Cuando esté publicable:

```bash
publish public
```

**Acabas de crear tu primera prueba pública de que sabes hacer BI.** En tu
LinkedIn, en tu CV, en tu firma de email, ahora puedes poner el link a este
repo.

### Qué tener en GitHub para internships

Cuando llegues a Fase 3, idealmente tendrás 3 a 5 repos públicos así:

| Repo | Tema | Demuestra |
|---|---|---|
| `luca-dotfiles` | Tu setup | Disciplina, atención al detalle, documentación |
| `analisis-inflacion-mexico-2024` | Tarea Tec adaptada | Python, pandas, visualización |
| `dashboard-tableau-ventas` | Proyecto Tableau | BI tools, storytelling con datos |
| `etl-twitter-sentimientos` | Side project | ETL, APIs, NLP básico |
| `sql-puzzles-leetcode` | Práctica SQL | SQL avanzado |

Reclutadores entran a tu GitHub y ven actividad real. No exagero la
importancia: **es la diferencia entre que te llamen o no.**

---

## Módulo E: Brewfile y portabilidad

Versiona todos tus paquetes para que tu setup sea portable a cualquier Mac.

```bash
cd ~/Projects/luca-dotfiles
brew bundle dump --file=./Brewfile --force
git add Brewfile
git commit -m "Add Brewfile: full BI stack snapshot"
git push
```

Si mañana cambias de Mac (laptop personal, Mac del trabajo, etc.), un solo
comando reinstala todo:

```bash
brew bundle --file=./Brewfile
```

Tu papá hizo esto exactamente la semana pasada cuando pasó del Mac Studio a
una MacBook Air M5 nueva. Setup completo en 15 minutos.

---

## Módulo F: Conexión a base de datos real

Las clases del Tec te dan PostgreSQL local. Pero los profesionales se
conectan a BDs en la nube.

### Opción 1: Supabase (gratis, lo que usan startups)

1. Ve a [supabase.com](https://supabase.com), crea cuenta con tu correo del Tec
2. New project, region us-east-1, password fuerte (guarda en password manager)
3. En tu proyecto, ve a Settings → Database → Connection string

Conectarte:

```bash
psql "postgresql://postgres:[password]@db.[ref].supabase.co:5432/postgres"
```

### Opción 2: Google BigQuery (lo que usan empresas grandes)

1. Crea cuenta gratis en [cloud.google.com](https://cloud.google.com) ($300 USD de crédito gratis)
2. Activa BigQuery
3. Tienes acceso a datasets públicos masivos: censos, COVID, Bitcoin, etc.

Conectarte desde Python:

```python
from google.cloud import bigquery
client = bigquery.Client()
query = "SELECT * FROM `bigquery-public-data.world_bank_intl_education.international_education` LIMIT 10"
df = client.query(query).to_dataframe()
```

### Por qué esto importa para internship

Cuando un reclutador pregunte "¿has trabajado con bases de datos en la
nube?", la respuesta correcta no es "tengo PostgreSQL local". Es "sí, he
conectado a Supabase y he hecho queries en BigQuery con datasets públicos".
Diferencia abismal.

---

## Cierre de Fase 2

```bash
cd ~/Projects/luca-dotfiles
nano README.md
```

Marca:
```
- [x] Fase 2: Workflows de internship
```

```bash
git add zshrc README.md Brewfile
git commit -m "Fase 2 complete: BI workflows, project templates, public portfolio"
git push
```

---

## Lo que tienes ahora

| Habilidad | Estado |
|---|---|
| Crear proyectos BI estructurados en 1 comando | Sí |
| Versionar trabajo académico profesionalmente | Sí |
| Portfolio público en GitHub | En construcción |
| Stack BI completo (Python, R, PostgreSQL, Jupyter) | Sí |
| VS Code configurado nivel pro | Sí |
| Conexión a BDs en la nube | Sí (básico) |

Esto es **más de lo que sabe el 90% de tus compañeros del LIT en este
momento.** Y si lo sigues usando, en 6 meses estará internalizado al punto
que no requerirá pensamiento consciente.

---

## Qué hacer las próximas 4 a 6 semanas

1. **Re-haz 2 tareas** del semestre pasado con la estructura nueva. Súbelas
   a GitHub público.
2. **Practica SQL** en un dataset público. Crea un repo `sql-practice` con
   queries documentadas.
3. **Conecta a Supabase o BigQuery** y haz al menos 1 análisis con datos en
   la nube.
4. **Personaliza tu starship.toml** si algo no te gusta.
5. **Documenta errores** en TROUBLESHOOTING.md cuando te topes con ellos.

Después de 1 a 2 meses con esto fluido, estás listo para Fase 3.

---

## Una nota personal

Luca, hasta aquí llegaron tus compañeros que se preocupan por su setup. Si
llegas a Fase 3, vas a estar en el 1%.

Pero lo que importa no es ser élite por elitismo. Es que cuando apliques a
tu primer internship en febrero/agosto del próximo año, te elijan.

Esa es la apuesta.

---

Continúa con: [`FASE_3_INTERNSHIP_READY.md`](FASE_3_INTERNSHIP_READY.md)
cuando estés listo.

Errores: [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md).
