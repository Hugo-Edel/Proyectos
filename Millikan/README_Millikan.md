# Simulación Computacional del Experimento de Millikan

> Replicación numérica del experimento de la gota de aceite de Millikan para determinar la carga elemental del electrón, implementada en MATLAB con métodos estadísticos de validación.

---

## Tabla de contenidos

- [Contexto](#contexto)
- [Objetivo](#objetivo)
- [Física del sistema](#física-del-sistema)
- [Metodología](#metodología)
- [Resultados](#resultados)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Requisitos](#requisitos)
- [Cómo ejecutar](#cómo-ejecutar)
- [Autores](#autores)

---

## Contexto

En 1909, Robert Millikan determinó experimentalmente el valor de la carga eléctrica elemental **e**, una de las constantes físicas más importantes de la física moderna. Su experimento demostró además que las cargas eléctricas se presentan exclusivamente en múltiplos enteros de esta cantidad.

Este proyecto replica ese experimento de forma numérica, simulando el comportamiento de gotas de aceite cargadas bajo la influencia de campos eléctricos ajustables.

---

## Objetivo

Estimar el valor de la carga elemental **e** mediante simulación computacional, buscando un margen de error menor al 10% respecto al valor aceptado actualmente:

$$e = 1.602 \times 10^{-19} \text{ C}$$

---

## Física del sistema

Las gotas de aceite dentro de la cámara están sujetas a cuatro fuerzas simultáneas:

| Fuerza | Expresión | Descripción |
|---|---|---|
| Gravedad | $F_g = \frac{4}{3}\pi r^3 \rho_{ac} g$ | Atrae la gota hacia abajo |
| Flotación (Arquímedes) | $F_a = \frac{4}{3}\pi r^3 \rho_{ai} g$ | Empuje del aire sobre la gota |
| Viscosa (Stokes) | $F_R = -6\pi r \eta v$ | Resistencia del aire al movimiento |
| Eléctrica | $F_e = qE = q\frac{V}{d}$ | Fuerza del campo eléctrico sobre la gota cargada |

El equilibrio de estas fuerzas permite despejar la carga **q** de cada gota:

$$q = \left(\frac{4}{3}\pi r^3 g(\rho_{ac} - \rho_{ai}) + 6\pi r \eta v\right) \frac{d}{V}$$

La simulación también incorpora el **ajuste de viscosidad de Millikan** para gotas de radio muy pequeño:

$$\eta_{eff} = \frac{\eta}{1 + \frac{A}{Pr}}$$

---

## Metodología

El experimento se divide en tres etapas:

**1. Caída libre sin campo eléctrico**
Se simulan 200 gotas con radios aleatorios entre 4×10⁻⁷ y 10×10⁻⁷ metros. Cada gota cae desde una altura de 6 mm partiendo del reposo. El método de Euler integra numéricamente la ecuación diferencial de movimiento hasta alcanzar la velocidad terminal.

**2. Ascenso con campo eléctrico**
Se aplica un voltaje aleatorio entre 300 V y 30,000 V. Cada gota recibe una carga eléctrica entera aleatoria del orden de 10⁻¹⁹ C. La fuerza eléctrica resultante invierte el movimiento y las gotas alcanzan una nueva velocidad terminal en sentido ascendente.

**3. Estimación estadística de e**
A partir de las velocidades terminales medidas se calculan las cargas de cada gota. Se aplica regresión lineal sobre la relación q = ne para estimar la pendiente, que corresponde a la carga elemental.

**Simulación del circuito RC**
Se modela el circuito que carga el capacitor formado por las placas experimentales, obteniendo la evolución temporal del voltaje, la carga acumulada y la intensidad del campo eléctrico.

---

## Resultados

| Métrica | Valor |
|---|---|
| Carga elemental estimada | $1.5961 \times 10^{-19}$ C |
| Carga elemental teórica | $1.6020 \times 10^{-19}$ C |
| Error porcentual | 0.2% – 0.7% |
| Error por mínimos cuadrados | $7.826 \times 10^{-44}$ |

Los valores calculados se ajustan con alta precisión a la línea de regresión lineal, confirmando la cuantización de la carga eléctrica en múltiplos enteros de **e**.

El circuito RC mostró un comportamiento logarítmico en la acumulación de carga, consistente con la teoría de circuitos de primer orden (τ = RC ≈ 2.339×10⁻¹² s).

---

## Estructura del proyecto

```
millikan-simulation/
│
├── src/
│   ├── Simulacion_ExperimentoDeMillikan.mlx #Script
│
├── results/
│   ├── WithoutElectricField.jpg   # Gráfico de velocidad vs posición en caída
│   ├── WithElectricField.jpg # Gráfico de velocidad vs posición en ascenso
│   ├── LinearRegressionEstimationOfCharge.jpg        # Scatter plot de carga vs múltiplo estimado
│   ├── ElementaryChargeMultipleDistribution.jpg # Distribución de múltiplos de e
│   ├── AccumChargeInCapacitor.jpg      # Carga acumulada en el capacitor vs tiempo
│   ├── AccumVoltageInCapacitor.jpg      # Voltaje acumulado en el capacitor vs tiempo
│   ├── ElectricFieldIntensity.jpg      # Intensidad de campo electrico vs tiempo
|   ├── VoltageToPositionDifference.jpg # Voltaje en el capacitor vs posicion
|   ├── VoltageToTimeDifference.jpg # Voltaje en el capacitor vs tiempo
|   └── ChargeInTheCapacitorDist.jpg # Distribucion de carga en el capacitor
└── README.md
```

---

## Requisitos

- MATLAB R2020a o superior
- Toolboxes requeridos: ninguno (solo funciones nativas de MATLAB)

---

## Cómo ejecutar

1. Clona el repositorio:
   ```bash
   git clone https://github.com/Hugo-Edel/Proyectos/blob/main/Millikan
   cd Simulacion_ExperimentoDeMillikan.mlx
   ```

2. Abre MATLAB y navega al directorio del proyecto.

3. Ejecuta el script principal:
   ```matlab
   open('src/Simulacion_ExperimentoDeMillikan.mlx')
   ```

Luego haz clic en **Run** o presiona Ctrl+Enter en cada sección.
El script generará automáticamente todas las gráficas y mostrará en consola los valores estimados de la carga elemental y el error calculado.

---

## Autores

Proyecto desarrollado para la materia **Sistemas Eléctricos en Ciencias** — Tecnológico de Monterrey, mayo 2025.

- Dana Paula Chapa Ortiz — A01286425
- Jose Luis Olavarrieta Rivera — A01068086
- Montserrat Rodríguez Ramírez — A01661271
- Hugo Edel Gamboa Sesma — A00841605
