# [Nombre del proyecto]

> [Una línea: qué problema resuelve]

## TL;DR

[2 a 3 líneas. Si alguien solo lee esto, debe entender qué hiciste y por
qué importa.]

## Pregunta de negocio

[Qué pregunta concreta responde este análisis. Ejemplo: "¿Cómo ha cambiado
el patrón de consumo en restaurantes de Riviera Maya post-pandemia?"]

## Datos

- **Fuente:** [INEGI, Kaggle, Banxico, datos.gob.mx, etc.]
- **Periodo:** [enero 2020 - diciembre 2024]
- **Volumen:** [10K registros, 25 columnas]
- **Calidad:** [problemas conocidos, valores faltantes, supuestos hechos]

## Stack

- Python 3.12 + pandas + scikit-learn
- PostgreSQL para queries
- Tableau para dashboard final
- (ajustar según lo que uses)

## Hallazgos principales

1. [Insight 1 con número concreto]
2. [Insight 2 con número concreto]
3. [Insight 3 con número concreto]

## Visualizaciones

[Embed de imagen o screenshot del dashboard. Las imágenes valen más que
mil palabras en GitHub.]

## Cómo reproducir

```bash
git clone [url-del-repo]
cd [nombre-proyecto]
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
jupyter lab notebooks/01_analisis.ipynb
```

## Estructura

| Folder | Qué tiene |
|---|---|
| data/raw | Datasets originales sin modificar |
| data/processed | Datos limpios y transformados |
| notebooks | Análisis exploratorio y modelado |
| src | Scripts reutilizables |
| reports | Outputs finales |

## Limitaciones

[Qué NO hace este análisis. Honestidad intelectual te diferencia.]

- [Limitación 1: e.g., los datos solo cubren CDMX, no nacional]
- [Limitación 2: e.g., no incluye estacionalidad]
- [Limitación 3: e.g., el modelo no captura efectos macro]

## Aprendizajes

[Qué aprendiste tú en el proceso. Esto humaniza el repo y demuestra
reflexión.]

- [Aprendizaje técnico]
- [Aprendizaje sobre el dominio]
- [Algo que harías diferente]

## Trabajo futuro

[Cómo extenderías este análisis si tuvieras más tiempo o datos]

---

Hecho por **Luca Villarreal** | LIT Tec de Monterrey | [LinkedIn](url) | [tu-correo@example.com]
