# Playbook: SQL Modeling

Para proyectos donde SQL es el centro de gravedad: queries analíticas
complejas, modelado dimensional (star schema, snowflake), ETL, optimización
de queries.

---

## Stack típico

```
PostgreSQL 16 (local o cloud: Supabase)
DBeaver o DataGrip como IDE
psql para CLI
SQLTools para VS Code
dbt si el proyecto crece (Fase 3 avanzada)
```

---

## Estructura de proyecto recomendada

```
proyecto-sql/
├── README.md
├── schema/
│   ├── 01_create_dimensions.sql
│   ├── 02_create_facts.sql
│   ├── 03_create_indexes.sql
│   └── 04_create_views.sql
├── etl/
│   ├── extract.sql
│   ├── transform.sql
│   └── load.sql
├── analysis/
│   ├── 01_basic_stats.sql
│   ├── 02_top_customers.sql
│   ├── 03_cohort_analysis.sql
│   └── 04_trend_analysis.sql
├── docs/
│   ├── data_dictionary.md
│   └── erd.png            # Entity Relationship Diagram
└── data/
    └── seed.csv           # Datos de prueba si aplica
```

---

## Reglas no negociables

1. **Schema antes que datos.** Crear tablas con tipos correctos primero,
   después poblarlas.

2. **Cada query con propósito.** No correr `SELECT * FROM tabla` en queries
   finales. Especificar columnas siempre.

3. **Comentarios en queries complejas.** Si una query tiene 3+ JOINs o
   CTEs, comentar cada parte.

4. **Índices después de queries.** Primero hacer la query, después
   optimizar con índices basados en el plan de ejecución.

5. **Versionar schemas con timestamp.** `01_create_dimensions_20260105.sql`
   si hay migraciones.

---

## Modelado dimensional: principios

### Star Schema básico

```sql
-- Fact table central
CREATE TABLE fact_ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha_id INT REFERENCES dim_fecha(fecha_id),
    producto_id INT REFERENCES dim_producto(producto_id),
    cliente_id INT REFERENCES dim_cliente(cliente_id),
    sucursal_id INT REFERENCES dim_sucursal(sucursal_id),
    cantidad INT,
    monto_neto DECIMAL(12,2),
    monto_iva DECIMAL(12,2),
    monto_total DECIMAL(12,2)
);

-- Dimensiones
CREATE TABLE dim_fecha (
    fecha_id INT PRIMARY KEY,
    fecha_completa DATE,
    dia INT,
    mes INT,
    trimestre INT,
    anio INT,
    dia_semana VARCHAR(20),
    es_fin_semana BOOLEAN
);

CREATE TABLE dim_producto (
    producto_id INT PRIMARY KEY,
    sku VARCHAR(50),
    nombre VARCHAR(200),
    categoria VARCHAR(100),
    subcategoria VARCHAR(100),
    precio_lista DECIMAL(12,2)
);
```

### Por qué dim_fecha es crucial

Permite agrupaciones temporales sin manipular fechas en queries:

```sql
-- Sin dim_fecha (engorroso)
SELECT EXTRACT(MONTH FROM fecha), SUM(monto_total)
FROM fact_ventas
GROUP BY EXTRACT(MONTH FROM fecha);

-- Con dim_fecha (limpio)
SELECT df.mes, df.anio, SUM(fv.monto_total) as total
FROM fact_ventas fv
JOIN dim_fecha df ON fv.fecha_id = df.fecha_id
GROUP BY df.mes, df.anio
ORDER BY df.anio, df.mes;
```

---

## Patrones de queries analíticas

### Top N con tiebreaking

```sql
-- Top 10 clientes por monto, con tiebreaking por cantidad
SELECT
    dc.nombre,
    COUNT(*) as ordenes,
    SUM(fv.monto_total) as total_compras
FROM fact_ventas fv
JOIN dim_cliente dc ON fv.cliente_id = dc.cliente_id
GROUP BY dc.cliente_id, dc.nombre
ORDER BY total_compras DESC, ordenes DESC
LIMIT 10;
```

### Cohort analysis con CTE

```sql
WITH primer_compra AS (
    SELECT
        cliente_id,
        DATE_TRUNC('month', MIN(fecha_completa)) as cohort
    FROM fact_ventas fv
    JOIN dim_fecha df ON fv.fecha_id = df.fecha_id
    GROUP BY cliente_id
),
compras_mensuales AS (
    SELECT
        fv.cliente_id,
        DATE_TRUNC('month', df.fecha_completa) as mes_compra,
        COUNT(*) as compras
    FROM fact_ventas fv
    JOIN dim_fecha df ON fv.fecha_id = df.fecha_id
    GROUP BY fv.cliente_id, DATE_TRUNC('month', df.fecha_completa)
)
SELECT
    pc.cohort,
    cm.mes_compra,
    EXTRACT(MONTH FROM AGE(cm.mes_compra, pc.cohort)) as meses_desde_cohort,
    COUNT(DISTINCT cm.cliente_id) as clientes_activos
FROM primer_compra pc
JOIN compras_mensuales cm USING (cliente_id)
GROUP BY pc.cohort, cm.mes_compra
ORDER BY pc.cohort, cm.mes_compra;
```

### Window functions para rankings y porcentajes

```sql
SELECT
    producto,
    categoria,
    ventas,
    -- Ranking dentro de categoría
    RANK() OVER (PARTITION BY categoria ORDER BY ventas DESC) as rank_categoria,
    -- Porcentaje del total de la categoría
    ventas * 100.0 / SUM(ventas) OVER (PARTITION BY categoria) as pct_categoria,
    -- Total acumulado
    SUM(ventas) OVER (PARTITION BY categoria ORDER BY ventas DESC) as acumulado
FROM ventas_por_producto;
```

---

## Optimización: cuándo crear índices

Solo después de identificar queries lentas. Workflow:

```sql
-- 1. Ver plan de ejecución
EXPLAIN ANALYZE
SELECT * FROM fact_ventas WHERE cliente_id = 12345;

-- Si dice "Seq Scan" en tabla grande, considerar índice:
CREATE INDEX idx_fact_ventas_cliente ON fact_ventas(cliente_id);

-- 2. Re-correr explain para verificar uso del índice
EXPLAIN ANALYZE
SELECT * FROM fact_ventas WHERE cliente_id = 12345;
-- Debe decir "Index Scan"
```

Índices típicos en data warehouses:

- Foreign keys de fact tables
- Columnas usadas frecuentemente en WHERE
- Columnas usadas en JOIN

NO crear índices en:

- Columnas con muchos UPDATEs (lento)
- Columnas con baja cardinalidad (sexo, true/false)
- Tablas pequeñas (overhead innecesario)

---

## Validaciones críticas en SQL

```sql
-- Sanity check básico de fact table
SELECT
    COUNT(*) as total_filas,
    COUNT(DISTINCT cliente_id) as clientes_unicos,
    MIN(fecha_id) as fecha_min,
    MAX(fecha_id) as fecha_max,
    SUM(monto_total) as suma_total,
    AVG(monto_total) as ticket_promedio
FROM fact_ventas;

-- Verificar integridad referencial
SELECT COUNT(*) as huerfanos
FROM fact_ventas fv
LEFT JOIN dim_cliente dc ON fv.cliente_id = dc.cliente_id
WHERE dc.cliente_id IS NULL;
-- Debe ser 0

-- Verificar duplicados accidentales
SELECT
    fecha_id, producto_id, cliente_id, COUNT(*)
FROM fact_ventas
GROUP BY fecha_id, producto_id, cliente_id
HAVING COUNT(*) > 1;
-- Debe estar vacío si la granularidad es correcta
```

---

## Errores típicos y cómo evitarlos

| Error | Síntoma | Mitigación |
|---|---|---|
| JOIN incorrecto | Más filas de las esperadas | Verificar cardinalidad antes (1:1, 1:N, N:N) |
| GROUP BY sin agregación | Error de SQL | Agregar todas las columnas no agregadas |
| WHERE después de JOIN con LEFT | Resultado tipo INNER JOIN | Filtros en ON, no en WHERE para LEFT |
| NULL en GROUP BY | Filas perdidas en agregaciones | COALESCE o filtrar NULLs explícitamente |
| Performance lenta | Query toma minutos | EXPLAIN ANALYZE, agregar índice |

---

## Conexión desde Python (cuando aplica)

```python
import pandas as pd
from sqlalchemy import create_engine

# Connection string para PostgreSQL local
engine = create_engine('postgresql://luca@localhost:5432/proyecto_db')

# Query a DataFrame
df = pd.read_sql("""
    SELECT
        df.anio,
        df.mes,
        SUM(fv.monto_total) as total
    FROM fact_ventas fv
    JOIN dim_fecha df ON fv.fecha_id = df.fecha_id
    GROUP BY df.anio, df.mes
    ORDER BY df.anio, df.mes
""", engine)

print(df.head())
```

Para Supabase / cloud PostgreSQL:

```python
import os
from dotenv import load_dotenv
load_dotenv()

engine = create_engine(os.getenv('DATABASE_URL'))
```

(Y `.env` con `DATABASE_URL=postgresql://...` siempre en `.gitignore`.)

---

## Checklist pre-entrega

- [ ] Schema documentado con ERD (entity relationship diagram)
- [ ] Data dictionary con descripción de cada tabla y columna
- [ ] Queries comentadas en sus partes complejas
- [ ] Índices justificados (no crear por crear)
- [ ] Sanity checks pasados (sin huérfanos, sin duplicados accidentales)
- [ ] README con setup instructions y queries de ejemplo
- [ ] Backup del schema en archivo `.sql` versionado en Git
