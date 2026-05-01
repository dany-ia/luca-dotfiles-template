# Playbook: Dashboards

Para proyectos donde el entregable es un dashboard interactivo. Tableau,
Power BI, o herramientas open source (Apache Superset, Metabase). Lo que
importa NO es la herramienta, son los principios de visualización.

---

## Stack típico

```
Tableau Desktop (estándar académico, licencia Tec)
Power BI Desktop (estándar enterprise México)
Looker Studio (gratis, decente para portfolios)
```

Para preparación de datos antes de cargar:

```
Python pandas para limpieza
SQL para agregaciones complejas
Excel solo para datasets <50K filas
```

---

## Reglas no negociables

1. **Scoping antes de construir.** Sin scoping con stakeholder, no se abre
   la herramienta. Una hora de scoping ahorra días de re-trabajo.

2. **Data validada antes de visualizar.** Si los datos crudos tienen
   errores, el dashboard hereda errores. Validar primero, visualizar
   después.

3. **Wireframe antes de Tableau.** Boceto en papel o Figma de las 3 a 5
   vistas principales. NO empezar drag-and-drop sin diseño.

4. **Una métrica por visualización, una historia por dashboard.** Si
   necesitas mostrar 10 métricas, son 10 dashboards, no 1 con todo.

5. **Reproducibilidad.** El dashboard debe poder reconstruirse desde los
   datos crudos. Documentar pasos.

---

## Fase 1: Scoping con stakeholder

Preguntas obligatorias antes de tocar herramienta:

| Pregunta | Por qué importa |
|---|---|
| ¿Qué decisión va a tomar con este dashboard? | Si no toma decisión, no necesita dashboard |
| ¿Quién lo va a ver? | Define nivel de detalle y vocabulario |
| ¿Con qué frecuencia? | Diario vs mensual cambia diseño |
| ¿En qué dispositivo? | Desktop vs mobile cambia layout |
| ¿Qué datos tiene actualmente? | Auditoría de fuentes |
| ¿Qué datos quisiera tener? | Identifica gaps |
| ¿Cuál es la métrica número 1? | Ancla del dashboard |

Output de Fase 1: documento de 1 página con respuestas, firmado mentalmente
(no literalmente) por stakeholder.

---

## Fase 2: Wireframe

ANTES de abrir Tableau o Power BI, dibujar:

```
┌─────────────────────────────────────────┐
│ TITULO DEL DASHBOARD                    │
│ [periodo] [filtro pais] [filtro categ.] │
├─────────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ │
│ │ KPI 1    │ │ KPI 2    │ │ KPI 3    │ │
│ │ $XXXM    │ │ XX%      │ │ XX,XXX   │ │
│ └──────────┘ └──────────┘ └──────────┘ │
├─────────────────────────────────────────┤
│ ┌─────────────────┐ ┌─────────────────┐ │
│ │ Tendencia       │ │ Top 10          │ │
│ │ [line chart]    │ │ [bar chart]     │ │
│ │                 │ │                 │ │
│ └─────────────────┘ └─────────────────┘ │
├─────────────────────────────────────────┤
│ Distribucion geografica                 │
│ [mapa coropletas]                       │
└─────────────────────────────────────────┘
```

Hecho a mano en Figma, en una hoja, en Excalidraw. NO importa la
herramienta. Importa el ejercicio mental antes de construir.

---

## Fase 3: Data preparation

Tableau y Power BI funcionan mejor con datos en formato "long" (no "wide").

### Wide (mal para BI tools)

| Producto | Ventas_Ene | Ventas_Feb | Ventas_Mar |
|---|---|---|---|
| A | 100 | 150 | 200 |
| B | 80 | 90 | 110 |

### Long (correcto)

| Producto | Mes | Ventas |
|---|---|---|
| A | Ene | 100 |
| A | Feb | 150 |
| A | Mar | 200 |
| B | Ene | 80 |
| B | Feb | 90 |
| B | Mar | 110 |

Pivotar de wide a long en pandas:

```python
df_long = df_wide.melt(
    id_vars=['Producto'],
    value_vars=['Ventas_Ene', 'Ventas_Feb', 'Ventas_Mar'],
    var_name='Mes',
    value_name='Ventas'
)
df_long['Mes'] = df_long['Mes'].str.replace('Ventas_', '')
```

---

## Principios de visualización

### Elección de chart type

| Pregunta de negocio | Chart correcto |
|---|---|
| ¿Cómo cambia X en el tiempo? | Line chart |
| ¿Cuánto X tiene cada categoría? | Bar chart (horizontal si nombres largos) |
| ¿Qué parte del total es X? | Pie/donut SOLO si <5 categorías, sino bar |
| ¿Cómo se relacionan X y Y? | Scatter plot |
| ¿Dónde geográficamente está X? | Mapa (coropletas o burbujas) |
| ¿Cuál es la distribución de X? | Histograma |
| ¿Qué tan correlacionadas son N variables? | Heatmap |

### Colores

- **Categóricos**: usar paleta categórica (Tableau 10, Power BI default)
- **Secuenciales** (ordenados): paleta secuencial (azules de claro a oscuro)
- **Divergentes** (positivo/negativo): paleta divergente (rojo-blanco-azul)
- **Máximo 7 colores categóricos.** Más de eso es ilegible
- **Consistencia entre vistas**: mismo color para misma categoría en todo
  el dashboard

### Texto

- Títulos: qué pregunta responde el chart, no qué dato muestra
  - ❌ "Ventas por mes"
  - ✅ "Las ventas crecen 15% mensual desde Q3"
- Números con formato: `$1.2M` no `1234567.89`
- Etiquetas en visualizaciones, no en leyenda separada cuando se pueda

---

## Patrones típicos

### KPI cards en la parte superior

3 a 4 números grandes que el stakeholder mira primero. Cada uno con:

- Número principal (formato compacto: `$1.2M`)
- Variación vs periodo anterior (`+15% vs mes anterior`)
- Color sutil (verde positivo, rojo negativo)

### Filtros globales

Posición: arriba o panel lateral izquierdo. Filtros típicos:

- Periodo (rango de fechas)
- Geografía (país, región, ciudad)
- Categoría (producto, segmento de cliente)

Máximo 4 a 5 filtros. Más de eso confunde.

### Drill-down

Permitir click en un elemento para ver detalle. Ejemplo: click en país en
mapa abre tabla de ciudades.

### Tooltip enriquecido

Al hacer hover sobre cualquier elemento, mostrar 3 a 5 datos extra. NO solo
el valor que ya está visible.

---

## Tableau específico

### Calculated fields útiles

```
// Variación vs periodo anterior
(SUM([Ventas]) - LOOKUP(SUM([Ventas]), -1)) / LOOKUP(SUM([Ventas]), -1)

// Categorizar
IF [Ventas] >= 1000000 THEN "Alta"
ELSEIF [Ventas] >= 500000 THEN "Media"
ELSE "Baja"
END

// Year-over-year crecimiento
(SUM([Ventas]) - LOOKUP(SUM([Ventas]), -12)) / LOOKUP(SUM([Ventas]), -12)
```

### Parameters para flexibilidad

Crear parameter que el usuario controla (ej: "Top N a mostrar") y
referenciarlo en filters/calculated fields.

---

## Power BI específico

### DAX básico

```dax
// Total ventas
Total Ventas = SUM(Ventas[Monto])

// Crecimiento YoY
Crecimiento YoY =
DIVIDE(
    [Total Ventas] - CALCULATE([Total Ventas], SAMEPERIODLASTYEAR(Calendario[Fecha])),
    CALCULATE([Total Ventas], SAMEPERIODLASTYEAR(Calendario[Fecha]))
)

// Top N dinámico con parameter
Top N Productos =
TOPN(
    [N Parameter],
    SUMMARIZE(Ventas, Ventas[Producto]),
    [Total Ventas]
)
```

### Tabla de calendario

Crear tabla DimFecha con todas las fechas del periodo. Conectar con
relaciones a las tablas de hechos. Permite análisis temporal limpio.

```dax
DimFecha =
ADDCOLUMNS(
    CALENDAR(DATE(2020,1,1), DATE(2026,12,31)),
    "Anio", YEAR([Date]),
    "Mes", MONTH([Date]),
    "Trimestre", "Q" & QUARTER([Date]),
    "DiaSemana", FORMAT([Date], "dddd")
)
```

---

## Validación del dashboard

NO entregar dashboard sin validar al menos 3 números contra los datos
crudos.

```python
# Verificar contra fuente
df_raw = pd.read_csv('data/raw/ventas.csv')
total_real = df_raw['monto'].sum()
print(f"Total real en fuente: ${total_real:,.2f}")

# Comparar contra dashboard
# Si dashboard muestra $1,234,567 y aquí sale $1,200,000, hay problema
```

Discrepancias comunes:

- Filtros silenciosos en el dashboard que excluyen filas
- Joins con duplicados que inflan totales
- Conversión de tipos (fechas, decimales) que pierde data
- Aggregaciones sobre joins (DISTINCT vs ALL)

---

## Errores típicos y mitigaciones

| Error | Síntoma | Mitigación |
|---|---|---|
| Demasiada info en una vista | Stakeholder pregunta "¿qué estoy viendo?" | Una métrica principal por vista |
| Colores caóticos | Cada chart con paleta diferente | Definir paleta una vez, replicar |
| Números sin contexto | "$1.2M" sin saber si eso es bueno | Comparar vs target, periodo anterior |
| Performance lento | Dashboard tarda 30s en abrir | Pre-agregar datos, reducir granularidad |
| Mobile no funciona | Stakeholder ve en celular y se rompe | Diseñar mobile-first o tener versión separada |
| Datos desactualizados | Dashboard muestra datos viejos | Documentar refresh schedule |

---

## Plantilla de README para proyecto de dashboard

```markdown
# Dashboard: [Nombre]

## Pregunta de negocio
[Una línea]

## Audiencia
[Quién lo va a usar]

## Frecuencia de uso
[Diario/semanal/mensual]

## Datos

| Fuente | Refresh | Volumen |
|---|---|---|
| [SQL Server prod] | Diario 6am | 500K filas/día |
| [API X] | Tiempo real | -- |

## Vistas principales

1. **Overview**: KPIs del mes vs targets
2. **Tendencia**: Evolución mensual últimos 12 meses
3. **Detalle por categoría**: Drill-down por producto
4. **Geografía**: Mapa por región

## Cómo reproducir

1. Conectar a [BD]
2. Abrir archivo `.twbx` o `.pbix`
3. Refresh de datos
4. Validar 3 números contra fuente

## Limitaciones

- [Qué NO responde este dashboard]
```

---

## Checklist pre-entrega

- [ ] Scoping documentado y firmado mentalmente con stakeholder
- [ ] Wireframe hecho antes de construir
- [ ] Datos validados (3 números contra fuente cruda)
- [ ] Paleta de colores consistente en todo el dashboard
- [ ] Títulos descriptivos (que responden, no que muestran)
- [ ] Mobile testing si aplica
- [ ] Performance <5 segundos para load inicial
- [ ] Refresh schedule documentado
- [ ] README con instrucciones de reproducción
- [ ] Tooltips enriquecidos en visualizaciones principales
