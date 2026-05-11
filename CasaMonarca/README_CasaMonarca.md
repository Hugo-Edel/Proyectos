# 🦋 Diet Cost Optimization — Casa Monarca Migrant Shelter

> **Linear programming applied to humanitarian food planning in Monterrey, México.**

---

## Context

[Casa Monarca](https://www.facebook.com/CasaMonarcaAyudaHumanitariaAC/) is a civil society organization located in Santa Catarina, Nuevo León, that shelters and supports migrants in transit through northern Mexico. On average, it serves **195 people per month** and delivers **over 1,000 meals per month**.

This project was developed as part of a deterministic optimization course challenge. The goal was to build a mathematical model capable of **minimizing the weekly food budget** of the shelter without compromising the nutritional adequacy of residents' diets.

---

## Problem Statement

Given a set of available foods and beverages, find the optimal daily quantities per person that:

- **Minimize** total weekly food cost
- **Meet** minimum nutritional requirements (energy, carbohydrates, protein, water)
- **Respect** the shelter's storage capacity for each item
- **Ensure dietary variety** (no single food dominates the diet)
- **Limit sodium and sugar** intake per WHO guidelines

Two population groups are modeled separately: **children** and **adults**, each with distinct nutritional requirements.

---

## Mathematical Formulation

### Sets

| Symbol | Description |
|--------|-------------|
| $i \in I$ | Food items (24 foods) |
| $j \in J$ | Beverages (5 options) |
| $k \in K$ | Age group: children / adults |
| $l \in L$ | Nutrients: energy, carbs, protein, water |

### Decision Variables

- $x_i$ — daily grams of food $i$ per person
- $y_j$ — daily milliliters of beverage $j$ per person

### Objective Function

$$\min \; z = 7h \left( \sum_{i} f_i \frac{x_i}{100} + \sum_{j} g_j \frac{y_j}{100} \right)$$

where $h$ is the number of residents and $f_i$, $g_j$ are costs per 100g/ml.

### Key Constraints

**Nutritional requirements** (per group $k$, per nutrient $l$):
$$\sum_{i} \frac{a_{i,l} \cdot x_i}{100} + \sum_{j} \frac{b_{j,l} \cdot y_j}{100} \geq d_{k,l}$$

**Storage capacity** (weekly):
$$7h \cdot x_i \leq c_i \quad \forall i$$

**Dietary variety** (no food exceeds 10% of total intake):
$$x_i \leq 0.10 \sum_{i'} x_{i'} \quad \forall i$$

**Sodium limit** (≤ 2,000 mg/day per WHO):
$$\sum_{i} \frac{\text{sodium}_i}{100} x_i \leq S_{\max}$$

---

## Stack

| Tool | Role |
|------|------|
| **GAMS 52.5.0** | Modeling environment |
| **CPLEX** | LP solver |
| **Linear Programming (LP)** | Optimization paradigm |

---

## Results

The model was solved for a population of **67 adults and 33 children** (100 residents total).

### Optimal Weekly Cost

| Group | Weekly Cost | Cost per Person per Day |
|-------|-------------|------------------------|
| Adults (67) | $43,429.40 MXN | $92.26 MXN |
| Children (33) | $4,745.36 MXN | $20.54 MXN |
| **Total** | **$48,174.76 MXN** | **$68.82 MXN** |

### Nutritional Coverage (Daily per Person)

| Nutrient | Adults — Achieved | Adults — Minimum | Children — Achieved | Children — Minimum |
|----------|:-----------------:|:----------------:|:-------------------:|:-----------------:|
| Energy (kcal) | 2,689 | 2,689 | 1,817 | 1,817 |
| Protein (g) | 125.0 | 47.8 | 29.1 | 16.0 |
| Carbohydrates (g) | 362.2 | 100.0 | 253.9 | 100.0 |
| Water (ml) | 2,980 | 2,980 | 1,500 | 1,500 |

### Sensitivity Analysis

**Varying time horizon** — Cost scales linearly with days (daily optimal solution repeated):

| Period | Total Cost |
|--------|-----------|
| 1 day | $6,859 MXN |
| 1 week | $48,015 MXN |
| 1 month | $205,780 MXN |

**Varying nutritional requirements** — Protein constraints are far more expensive than caloric ones:

| Scenario | Total Cost |
|----------|-----------|
| Base | $48,015 MXN |
| +200 kcal | $49,799 MXN (+3.7%) |
| +200 kcal + 50g protein | $52,457 MXN (+9.2%) |

**Varying population composition** — Budget is significantly more sensitive to the number of adults than children:

| Population | Total Cost |
|-----------|-----------|
| 33 children / 67 adults (base) | $48,015 MXN |
| 15 children / 30 adults | $8,684 MXN |
| 60 children / 65 adults | $45,934 MXN |

---

## Key Findings

- The **binding constraint** is the adult energy requirement — all other nutrients are met with slack.
- Several items (oil, flour, salt, beans, tomato, onion, potato, carrot, lettuce, chili, egg, sugar, bread) **hit their full storage capacity**, indicating that increasing their supply could reduce cost or serve more residents.
- **Protein costs more than calories**: adding 200 kcal raises costs ~4%, but adding 50g of protein raises costs ~9% for children, forcing a shift toward animal-protein sources.
- **Adult count drives cost** more than child count — a small change in adults has greater financial impact than an equivalent change in children.
- The model recommends **no vegetable proteins for children** in the optimal solution, which is a practical limitation that the shelter should address by slightly deviating from the strict optimum.

---

## Repository Contents

```
├── CasaMonarca_OptimizacionDeDietas.gms   # Full GAMS model
├── CasaMonarca_OptimizacionDeDietas.pdf   # Full technical report (Spanish)
└── README.md
```

---

## Recommendations for Casa Monarca

The optimal solution provides **weekly purchasing guidelines**, not a daily menu. Casa Monarca's team can distribute the weekly ingredient quantities across different dishes and meals according to cultural and practical criteria. Specific recommendations derived from the model:

1. **Increase storage capacity** for high-impact items (oil, beans, egg, bread) to potentially serve more residents at the same per-person cost.
2. **Adjust energy requirements** — the WHO-based minimum could be lowered by 100–200 kcal and still be nutritionally adequate, enabling the model to serve a larger population.
3. **Add animal protein for children** by slightly deviating from the strict optimum or raising the protein minimum in the model until a satisfactory animal-protein content is reached.
4. **Vary daily menus** within the same weekly totals to avoid dietary monotony — the model optimizes quantities, not recipes.
5. **Run sensitivity analysis** regularly as food prices in Monterrey fluctuate.

---

## Ethical Note

The nutritional and availability data used in this model were provided directly by Casa Monarca. All recommendations are to be interpreted as **planning guidelines**, not prescriptions. Practical, cultural, and individual factors should always inform final decisions about food provision in humanitarian settings.

---

## Authors

- Hugo Edel Gamboa Sesma
- Pompeyo Alexander Pérez Marín
- Pedro Valdez Flores
- Rafael Sánchez Ramírez

*Deterministic Optimization Challenge — February 2026*

---

## References

- World Health Organization. (2023). *Healthy diet*. https://www.who.int
- Health Canada. (2015). *Dietary Reference Intakes tables*.
- Peters et al. (2021). The Nutritious Supply Chain: Optimizing Humanitarian Food Assistance. *INFORMS*.
- Alaini et al. (2019). Diet optimization using linear programming. *BMC Public Health*.
