# Playbook: Python BI

Para proyectos que combinan pandas, numpy, scikit-learn, statsmodels,
Jupyter. Cubre el 70% de los proyectos de Luca: tareas del Tec, modelos
predictivos, análisis exploratorio.

---

## Stack típico

```python
# Manipulación
pandas
numpy

# Visualización
matplotlib
seaborn
plotly  # si se quiere interactivo

# Modelado
scikit-learn
statsmodels  # para econometría
xgboost  # para ensemble avanzado

# Jupyter
jupyter lab

# Persistencia
joblib  # para serializar modelos
```

---

## Estructura de proyecto recomendada

```
proyecto/
├── README.md
├── requirements.txt
├── data/
│   ├── raw/           # Sin tocar, fuente original
│   └── processed/     # Limpio, listo para modelar
├── notebooks/
│   ├── 01_eda.ipynb               # Exploratorio
│   ├── 02_cleaning.ipynb          # Limpieza
│   ├── 03_feature_engineering.ipynb
│   ├── 04_modeling.ipynb
│   └── 05_evaluation.ipynb
├── src/
│   ├── data_loader.py    # Funciones de carga
│   ├── features.py       # Feature engineering reutilizable
│   └── models.py         # Definición de modelos
├── reports/
│   ├── figures/          # Gráficas exportadas
│   └── final_report.pdf
└── models/               # Modelos serializados (.joblib)
```

---

## Reglas no negociables

1. **El folder `data/raw/` es sagrado.** Nunca se modifica. Si se requiere
   limpieza, output va a `data/processed/`.

2. **Notebooks numerados secuencialmente.** El 01 corre antes que el 02.
   Si un notebook depende de outputs de otro, cargarlos desde
   `data/processed/`, nunca desde memoria de otro notebook.

3. **Funciones reutilizables van a `src/`.** Si una función la usas en 2
   notebooks, va a un .py importado.

4. **requirements.txt siempre actualizado.** Después de cada `pip install`,
   correr `pip freeze > requirements.txt`.

5. **Cells limpias antes de commit.** Reiniciar kernel y correr todo de
   cero para verificar reproducibilidad. Números de celdas consistentes.

---

## Fases típicas y validaciones

### Fase 1: EDA (Exploratory Data Analysis)

Mensaje a Claude Code:

```markdown
## Requisitos técnicos

Crear notebooks/01_eda.ipynb con estructura:
- Imports y carga de data/raw/[archivo]
- df.shape, df.dtypes, df.head()
- df.describe() para numéricas
- df.isnull().sum() para missing values
- Distribuciones univariadas con histogramas
- Boxplots para detectar outliers
- Correlation matrix con seaborn.heatmap
- Conclusiones del EDA en celda final markdown

## Validaciones que haré yo después

- Verificar shape contra fuente original
- Confirmar tipos de datos coherentes
- Revisar visualizaciones por sentido común
```

Validaciones típicas en Terminal/Jupyter:

```python
df.shape
df.head()
df.describe()
df.isnull().sum()
df.dtypes
```

### Fase 2: Limpieza

Decisiones metodológicas a tomar antes:

- ¿Cómo tratar NAs? (imputar con media, mediana, drop, marker -1)
- ¿Cómo tratar outliers? (winsorize, IQR clip, drop, mantener)
- ¿Necesitamos normalizar? (StandardScaler, MinMaxScaler, no normalizar)
- ¿Variables categóricas cómo? (one-hot, label encoding, target encoding)

Validaciones críticas:

```python
# Antes y después de limpieza
df_raw.shape
df_clean.shape
print(f"Filas perdidas: {df_raw.shape[0] - df_clean.shape[0]} ({(df_raw.shape[0] - df_clean.shape[0])/df_raw.shape[0]*100:.1f}%)")

# Verificar que no hayan quedado NAs si el plan era removerlos
df_clean.isnull().sum()
```

### Fase 3: Feature Engineering

Reglas:

- Cada feature nueva tiene justificación en comentario o markdown
- Features derivadas de fechas: extraer year, month, dayofweek si aplica
- Features de interacción solo si tienen sentido de negocio
- Documentar features dropeadas y por qué

### Fase 4: Modeling

**Siempre baseline primero:**

```python
# Baseline simple para tener referencia
from sklearn.dummy import DummyClassifier
baseline = DummyClassifier(strategy='most_frequent')
baseline.fit(X_train, y_train)
print(f"Baseline accuracy: {baseline.score(X_test, y_test):.3f}")
```

Después, modelo lineal (interpretable):

```python
from sklearn.linear_model import LogisticRegression
lr = LogisticRegression(max_iter=1000)
lr.fit(X_train, y_train)
```

Solo después, ensemble:

```python
from sklearn.ensemble import RandomForestClassifier
rf = RandomForestClassifier(random_state=42)
rf.fit(X_train, y_train)
```

### Fase 5: Evaluación

NO solo accuracy. Para clasificación:

```python
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    confusion_matrix, classification_report, roc_auc_score
)

print(classification_report(y_test, y_pred))
print(f"AUC: {roc_auc_score(y_test, y_proba):.3f}")
```

Para regresión:

```python
from sklearn.metrics import (
    mean_squared_error, mean_absolute_error, r2_score
)

print(f"RMSE: {mean_squared_error(y_test, y_pred, squared=False):.3f}")
print(f"MAE: {mean_absolute_error(y_test, y_pred):.3f}")
print(f"R²: {r2_score(y_test, y_pred):.3f}")
```

---

## Errores típicos y mitigaciones

| Error | Síntoma | Mitigación |
|---|---|---|
| Data leakage | Accuracy sospechosamente alta | Verificar que features no contengan info del futuro |
| Class imbalance ignorado | Accuracy alta pero recall bajo en minoría | `class_weight='balanced'` o SMOTE |
| Test set contaminado | Resultados optimistas | Aplicar transformaciones solo después de split |
| Overfitting | Train >> test accuracy | Cross-validation, regularización, más datos |
| Multicolinealidad | Coeficientes raros en regresión | VIF, drop features correlacionadas |

---

## Plantilla de requirements.txt para BI

```
pandas==2.1.0
numpy==1.26.0
scikit-learn==1.3.0
statsmodels==0.14.0
matplotlib==3.8.0
seaborn==0.13.0
jupyter==1.0.0
joblib==1.3.2
```

(Versiones se actualizan con `pip freeze > requirements.txt`)

---

## Checklist pre-entrega

- [ ] Notebook 01 a 05 corren sin errores desde kernel limpio
- [ ] README.md con TL;DR, datos, stack, hallazgos, limitaciones
- [ ] requirements.txt actualizado
- [ ] Modelo serializado en `models/` si aplica
- [ ] Visualizaciones clave exportadas a `reports/figures/`
- [ ] .gitignore excluye data/raw/ y data/processed/ si son pesados
- [ ] Commits granulares con mensajes claros
- [ ] Si es público: repo limpio sin secretos ni datos confidenciales
