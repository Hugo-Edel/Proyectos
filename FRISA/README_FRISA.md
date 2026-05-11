# Reducción de Desperdicios en Manufactura de Anillos Rolados con Machine Learning

Modelos de aprendizaje automático interpretables para identificar y reducir el exceso innecesario de material en el proceso de forja de anillos rolados, desarrollado en colaboración con **FRISA**, empresa industrial de manufactura de piezas forjadas.

---

## Contexto del Problema

El material representa aproximadamente el **50% de los costos operativos** de FRISA. La empresa estimaba perder alrededor del **40% del material adquirido** en forma de excesos innecesarios durante el proceso de manufactura de anillos rolados.

FRISA nos solicitó desarrollar un monitor de excesos que les permitiera reducir ese desperdicio sin aumentar el riesgo de piezas defectuosas o fuera de especificación.

---

## Hallazgos del Análisis Exploratorio (EDA)

El EDA reveló descubrimientos contraintuitivos que reorientaron el enfoque del proyecto:

- **El problema no es entre familias, sino sistemático:** Todas las familias geométricas subestiman el exceso real en diámetro exterior (DE), lo que indica un sesgo generalizado en el algoritmo de configuración de excesos de FRISA.
- **El exceso no protege contra defectos:** Solo ~15% de las piezas defectuosas tienen problemas relacionados con falta de exceso. Otros defectos como pozos, descascarados y traslapes se asocian con excesos *mayores*, no menores.
- **La roladora R3 concentra más irregularidades:** Consistente con el hallazgo anterior, al procesar los anillos de mayor diámetro exterior, presenta la mayor proporción de defectos.
- **Problema grave de captura de datos:** Los operadores omiten intencionalmente defectos que esperan corregir en maquinado. De 19 piezas marcadas con rechazo por ovalamiento, solo 3 tenían ovalamiento distinto de cero registrado.

---

## Modelos Implementados

| Modelo | Objetivo | Métrica principal |
|---|---|---|
| **Árbol de Decisión** | Clasificar piezas candidatas a reducción de exceso volumétrico | Precisión: **93%** (cross-validation) |
| Regresión Lineal Múltiple | Recalibrar el algoritmo de excesos de FRISA corrigiendo sesgos sistemáticos en DE | Coeficientes por familia y roladora |

### Árbol de Decisión — Detalle

Se definió una variable objetivo binaria basada en la razón entre el exceso volumétrico real y el configurado. Un umbral de **1.1** (exceso real 10% mayor al configurado) fue seleccionado como frontera conservadora que maximiza el potencial de ahorro sin incrementar riesgos operativos.

**Variables seleccionadas por RFE:**

| Variable | Importancia |
|---|---|
| Peso de Forja Configurado | 39.1% |
| Exceso DI Configurado | 23.2% |
| DI Forja Configurada | 20.5% |
| Altura Forja Configurada | 17.1% |

**Métricas (cross-validation, 5 folds):**

| Métrica | Valor |
|---|---|
| Precisión | 0.929 |
| Recall | 0.747 |
| F1-Score | 0.828 |
| AUC-ROC | 0.853 |

La **precisión** fue la métrica prioritaria: una precisión del 93% significa que el 93% de las piezas marcadas como candidatas a reducción realmente lo son, lo que permite actuar con seguridad sobre ellas.

### Impacto Estimado

Actuar sobre las piezas clasificadas como excedidas con una reducción conservadora del 10% en volumen representa:

- **> 16 m³** de material recuperable
- Equivalente a aproximadamente **125 toneladas métricas** de acero

---

## Estructura del Repositorio

```
├── FRISA_AnalisisExploratorio.ipynb   # EDA: limpieza, análisis de eficiencia, calidad y familia geométrica
├── FRISA_ArbolDeDecisión.ipynb        # Modelos ML: árbol de decisión y regresión lineal múltiple
├── FRISA_AnalisisExploratorio.docx    # Reporte escrito del EDA
├── FRISA_reporte.docx                 # Reporte final del modelado
└── README.md
```

---

## Stack Tecnológico

- **Python** — pandas, NumPy, scikit-learn, statsmodels, XGBoost
- **Visualización** — matplotlib, seaborn, dtreeviz
- **Entorno** — Google Colab

---

## Mi Contribución

Este proyecto fue desarrollado por un equipo de 5 personas. Mi responsabilidad principal fue el **modelo de árbol de decisión**, que incluyó:

- Ingeniería de las variables de exceso volumétrico configurado y real a partir de geometría de anillo
- Definición y justificación del umbral de clasificación (1.1)
- Selección de variables mediante RFE y análisis de importancias
- Evaluación del modelo con cross-validation estratificada, curva ROC y matriz de confusión
- Interpretación de resultados en términos de impacto operativo para FRISA

La regresión lineal múltiple fue desarrollada por otro integrante del equipo.

---

## Contexto Académico

Proyecto desarrollado para el curso **Análisis de Ciencia de Datos** en el **Tecnológico de Monterrey** (2026), en colaboración con FRISA como socio formador.

**Equipo:** Hugo Edel Gamboa Sesma · Diego Villalón Aguilar · Sebastián Hernández Gómez · Enrique Alexander Luna Sánchez · Alejandro Israel Manducano Rojo

**Profesores:** Mauricio González Soto · María de los Ángeles Constantino González
