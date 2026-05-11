# Portafolio de Proyectos Académicos

**Hugo Edel Gamboa Sesma — A00841605**
Tecnológico de Monterrey · 2025–2026

Tres proyectos aplicados en manufactura, humanitarismo y física computacional, desarrollados en colaboración con organizaciones reales.

---

## 1. Reducción de Desperdicios en Manufactura de Anillos Rolados

**Área:** Machine Learning interpretable
**Socio industrial:** FRISA
**Curso:** Análisis de Ciencia de Datos (2026)

FRISA estimaba perder alrededor del 40% del material adquirido en excesos innecesarios durante la manufactura de anillos rolados. Se desarrollaron modelos de ML para identificar piezas candidatas a reducción de exceso volumétrico sin incrementar el riesgo de defectos.

El análisis exploratorio reveló un sesgo sistemático en el algoritmo de configuración de excesos de FRISA —no limitado a familias específicas de piezas— y que el exceso adicional no reduce los defectos, sino que se asocia con tipos de falla distintos (pozos, descascarados, traslapes).

**Modelo principal:** Árbol de Decisión con selección de variables por RFE.

| Métrica | Valor |
|---|---|
| Precisión (cross-validation) | 93% |
| AUC-ROC | 0.85 |
| Material recuperable estimado | ~125 toneladas métricas |

**Mi contribución:** Ingeniería de variables de exceso volumétrico, definición del umbral de clasificación, selección por RFE, evaluación con cross-validation estratificada e interpretación operativa de resultados.

**Stack:** Python · scikit-learn · pandas · NumPy · XGBoost · dtreeviz · Google Colab

---

## 2. Optimización del Costo de Dieta — Casa Monarca

**Área:** Programación lineal / Optimización determinista
**Socio:** [Casa Monarca](https://www.facebook.com/CasaMonarcaAyudaHumanitariaAC/) (albergue de migrantes, Santa Catarina, N.L.)
**Curso:** Reto de Optimización Determinista (febrero 2026)

Casa Monarca atiende en promedio 195 personas por mes y sirve más de 1,000 comidas mensuales. Se construyó un modelo de programación lineal para minimizar el costo semanal de alimentación sin comprometer los requerimientos nutricionales de adultos y niños.

El modelo contempla 24 alimentos y 5 bebidas, restricciones de almacenamiento, variedad dietética (ningún alimento supera el 10% del total), límites de sodio según la OMS, y grupos de edad diferenciados.

**Resultado óptimo (100 residentes: 67 adultos, 33 niños):**

| Grupo | Costo semanal | Costo por persona/día |
|---|---|---|
| Adultos (67) | $43,429 MXN | $92.26 MXN |
| Niños (33) | $4,745 MXN | $20.54 MXN |
| **Total** | **$48,015 MXN** | **$68.82 MXN** |

La restricción activa es el requerimiento energético de adultos. El costo es significativamente más sensible al número de adultos que al de niños, y añadir proteína resulta más caro que añadir calorías equivalentes.

**Stack:** GAMS 52.5.0 · CPLEX · Programación Lineal (LP)

---

## 3. Simulación Computacional del Experimento de Millikan

**Área:** Física computacional / Simulación numérica
**Curso:** Sistemas Eléctricos en Ciencias — Tecnológico de Monterrey (mayo 2025)

Replicación numérica del experimento de la gota de aceite de Millikan para estimar la carga elemental del electrón. Se simularon 200 gotas con radios aleatorios entre 4×10⁻⁷ y 10×10⁻⁷ metros, sometidas a caída libre y posterior ascenso bajo campo eléctrico variable. El método de Euler integra numéricamente las ecuaciones de movimiento incluyendo el ajuste de viscosidad de Millikan para gotas pequeñas.

La carga elemental se estima mediante regresión lineal sobre la relación q = ne, confirmando la cuantización de la carga eléctrica.

| Métrica | Valor |
|---|---|
| Carga estimada | 1.5961 × 10⁻¹⁹ C |
| Valor teórico | 1.6020 × 10⁻¹⁹ C |
| Error porcentual | 0.2% – 0.7% |

También se modela el circuito RC que carga el capacitor formado por las placas experimentales (τ ≈ 2.339×10⁻¹² s).

**Stack:** MATLAB · Método de Euler · Regresión lineal por mínimos cuadrados

---

## Cursos y materias

| Proyecto | Materia | Año |
|---|---|---|
| FRISA — Desperdicios en manufactura | Análisis de Ciencia de Datos | 2026 |
| Casa Monarca — Optimización de dieta | Reto de Optimización Determinista | 2026 |
| Simulación de Millikan | Sistemas Eléctricos en Ciencias | 2025 |

---

*Tecnológico de Monterrey — Ingeniería y Ciencias*
