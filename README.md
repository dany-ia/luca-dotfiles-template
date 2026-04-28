# luca-dotfiles

El upgrade que tus compañeros del Tec no están haciendo.

Stack: dotfiles versionados + workflows profesionales + portfolio público +
**`papa-copilot` skill personalizada**, configurado para que cuando entres a
tu primer internship, parezcas senior desde el día 1.

---

## La verdad incómoda

Estás a mitad de la carrera. En 2 a 3 semestres vas a aplicar a internships
en empresas serias. Y aquí está el dato que nadie te dice:

**El 95% de tus compañeros del LIT entregan tareas profesionales con setups
de amateur.**

Hacen análisis brillantes en notebooks, pero los entregan como archivos
sueltos en un Drive. Saben SQL, pero no tienen un repo público que lo
demuestre. Conocen Tableau, pero su Mac se ve igual al día que la sacaron de
la caja.

Cuando un reclutador de Bain, Deloitte, KPMG, Banamex, Heineken, o Globant
los entreviste, va a preguntar:

- "Mándame tu GitHub" → 95% no tiene
- "Cuéntame de un proyecto" → 95% lo cuenta de memoria, sin código que mostrar
- "¿Cómo organizas tu trabajo?" → 95% improvisa la respuesta

Este repo es para que tú seas el 5%.

---

## Qué vas a obtener

| Después de | Vas a tener |
|---|---|
| **Fase 1** (1 sesión) | Setup visual profesional + dotfiles versionados + workflow diario que duplica tu velocidad |
| **Fase 2** (1 a 2 sesiones) | Stack BI con virtualenvs serios + portfolio público de tareas + GitHub que se ve como el de un junior contratable |
| **Fase 3** (a tu ritmo) | Conexiones a BDs en la nube + Claude Code + Docker + casos públicos demostrables = perfil de internship-ready |
| **`papa-copilot`** | Skill custom que tu papá hizo para ti. Acompañamiento estratégico para todos tus proyectos de datos. |

Cuando termines, tendrás 2 cosas que la mayoría de tus compañeros no tendrán:

1. **Un repo público que cuenta tu historia técnica.** Reclutadores lo miran
   3 minutos y deciden si quieren hablar contigo.
2. **Un setup que se ve serio en pantalla.** Cuando hagas screen-share en una
   entrevista, tu terminal y tu IDE comunican "esta persona sabe lo que hace"
   antes de que abras la boca.

---

## Filosofía

**No es sobre instalar herramientas. Es sobre versionar tu inteligencia.**

Cada commit es evidencia de que pensaste algo. Cada README es evidencia de
que sabes comunicarte. Cada repo es evidencia de que terminas lo que
empiezas.

Las empresas no te contratan por tus calificaciones. Te contratan por la
evidencia de que puedes producir.

---

## Las 3 fases + el regalo

| Fase | Cuándo | Tiempo | El por qué |
|---|---|---|---|
| **Fase 1: Profesionalizar lo que ya tienes** | Esta semana | 2 a 3 hrs | Tu Mac actual probablemente está a 60% de su potencial. Subámoslo a 90%. |
| **Fase 2: Workflows de internship** | Mes 1 a 2 | Sesiones cortas | Cómo entregar trabajo en empresas reales. Diferente a cómo lo entregas en clases del Tec. |
| **Fase 3: Internship-ready** | Antes de aplicar a tu primer internship | A tu ritmo | Cuando termines, tu perfil compite con egresados, no con compañeros de carrera. |
| **papa-copilot skill** | Cuando empieces tu primer proyecto serio (Fase 2+) | Setup en 5 min | Copiloto estratégico personalizado. Acompañamiento de tu papá vía Claude. |

Lee Fase 1 entera primero antes de ejecutar. Te toma 15 min y te ahorra
confusiones.

---

## Cómo navegar el repo

```
luca-dotfiles/
├── README.md                       # Estás aquí
├── docs/
│   ├── FASE_1_PROFESIONALIZAR.md   # Setup actual → setup pro
│   ├── FASE_2_WORKFLOWS.md         # Cómo trabajan los profesionales
│   ├── FASE_3_INTERNSHIP_READY.md  # Portfolio público + cloud + diferenciadores
│   └── TROUBLESHOOTING.md          # Cuando algo se rompe
├── zshrc                           # Configuración de shell (Fase 1)
├── starship.toml                   # Prompt visual Tokyo Night (Fase 1)
├── Brewfile                        # Stack completo (Fase 2)
├── iterm2/                         # Tema y prefs visuales
├── casos/                          # Templates para casos públicos (Fase 3)
├── scripts/
│   └── audit-setup.sh              # Diagnóstico rápido de tu setup actual
└── papa-copilot/                   # ⭐ Skill custom de Claude para ti
    ├── README.md                   # Cómo instalar y usar la skill
    ├── SKILL.md                    # La skill en sí
    └── references/                 # 3 playbooks (Python BI, SQL, Dashboards)
```

---

## Por dónde empezar

### Si llegaste a este repo por primera vez

1. Lee este README completo
2. Corre el audit de tu setup actual:
   ```bash
   bash scripts/audit-setup.sh
   ```
3. Lee `docs/FASE_1_PROFESIONALIZAR.md` completo antes de ejecutar
4. Empieza la Fase 1 cuando tengas 2 a 3 horas continuas

### Si ya hiciste Fase 1 y quieres seguir

- Continúa con `docs/FASE_2_WORKFLOWS.md`
- Cuando llegues a tu primer proyecto serio, instala la skill `papa-copilot`
  siguiendo `papa-copilot/README.md`

### Si algo se rompió

- Ve a `docs/TROUBLESHOOTING.md` primero
- Si no está tu error ahí, le hablas a tu papá

---

## La skill papa-copilot (regalo especial)

Tu papá diseñó una skill custom de Claude específicamente para ti. Es un
copiloto estratégico que te acompaña en todos tus proyectos de datos.

**No** escribe código (eso lo hace Claude Code). Lo que hace es:

- Estructurar tus proyectos en fases ejecutables
- Validar tus decisiones metodológicas antes de tocar código
- Evaluar reportes de Claude Code críticamente
- Proponer mitigaciones cuando vas con prisa
- Cerrar proyectos con calidad de portfolio

La metodología es la misma que usa tu papá en sus consultorías DANVILX,
adaptada al stack BI tuyo (Python, R, SQL, Tableau, Power BI).

**Cómo instalar:** ver `papa-copilot/README.md`

**Cómo activar:** escribe "activa papa-copilot" en cualquier conversación
con Claude.

---

## Notas para el largo plazo

Este repo es vivo. A lo largo de tu carrera vas a:

- Agregar funciones zsh nuevas que descubras
- Versionar nuevas configuraciones de tools
- Documentar errores que hayas resuelto en TROUBLESHOOTING.md
- Actualizar el Brewfile cuando cambies de Mac
- Posiblemente crear nuevas skills custom

En 4 a 5 años, este repo será tu firma digital. Mantenlo limpio, mantenlo
vivo.

---

LIT Tec de Monterrey - Generación en curso.
Repo de tu papá para inspiración: `dany-ia/danvilx-dotfiles`.
