Option solprint=off;
Option limrow=0;
Option limcol=0;


Sets
* Alimentos
    i
       / aceite, tortilla, harina, sal, galletas, pasta,
         pastel, cilantro, arroz, frijol, jitomate, cebolla,
         papa, zanahoria, espinaca, champinon, lechuga, chile,
         huevo, azucar, pan, atun, pollo, res /
* Líquidos
    j
       / agua, leche, cafe, saborizante, refresco /

* Grupos Etarios
    k
       / ninos, adultos /

* Requerimientos Nutricionales
    l
       / energia, carbohidratos, proteinas, agua /
;

Alias(i, ii);


* COntenido nutricional alimento por 100g
Table a(i,l)
                 energia  carbohidratos  proteinas    agua
aceite           884.00       0.00        0.00        0.00
tortilla         155.20      32.00        3.20        0.00
harina           147.99      29.57        3.04        0.00
sal                0.00       0.00        0.00        0.00
galletas         475.00      68.70        5.60        0.00
pasta            170.90      35.10        6.50        0.00
pastel           358.00      53.40        5.30        0.00
cilantro          23.00       3.67        2.13        0.00
arroz            359.00      80.30        7.04       11.20
frijol           341.00      62.40       21.60       11.00
jitomate          27.00       5.51        0.83       92.50
cebolla           35.00       7.68        0.89       91.30
papa              73.50      16.00        1.81       81.10
zanahoria         48.00      10.30        0.94       87.70
espinaca          27.60       2.64        2.91       92.40
champinon         31.20       4.08        2.89       91.80
lechuga           17.10       3.37        0.74       95.50
chile             24.10       5.08        0.62       93.80
huevo            148.00       0.96       12.40       75.80
azucar           385.00      99.60        0.00        0.02
pan              270.00      49.20        9.43       35.70
atun              90.00       0.08       19.00       79.00
pollo            106.00       0.00       22.50       74.80
res              198.00       0.00       19.40       67.10
;


* COntenido nutricional bebida por 100ml
Table b(j,l)
                 energia  carbohidratos  proteinas    agua
agua               0.00       0.00        0.00      100.00
leche             68.00       4.60        3.50       88.00
cafe               0.00       0.00        0.00      100.00
saborizante       38.00      10.00        0.00       99.00
refresco          42.00      10.00        0.00       99.00
;


* Rquerimientos nutricionales
Table d(k,l)
                 energia  carbohidratos  proteinas    agua
ninos            1817.00      100.00       16.00     1500.00
adultos          2689.00      100.00       47.80     2980.00
;


* Disponibilidad semanal alimentos
Parameter c(i)
    / aceite      21000, tortilla   126000, harina      42000, sal          1750
      galletas    33600, pasta       42000, pastel       8400, cilantro     1750
      arroz       84000, frijol      21000, jitomate    21000, cebolla     28000
      papa        28000, zanahoria   21000, espinaca     3500, champinon    3500
      lechuga      3500, chile        1750, huevo       50400, azucar      21000
      pan         35000, atun        49000, pollo       84000, res         70000 /
;

* Disponibilidad semanal bebidas
Parameter e(j)
    / agua       840000, leche       35000, cafe         3500
      saborizante   756, refresco   245000 /
;


* Costos por 100g alimentos
Parameter f(i)
    / aceite      4.757, tortilla    2.200, harina      2.200, sal         1.400
      galletas   11.458, pasta       4.200, pastel     25.000, cilantro   14.000
      arroz       2.150, frijol      3.556, jitomate    2.600, cebolla     2.500
      papa        2.500, zanahoria   2.500, espinaca   11.000, champinon  12.000
      lechuga     6.667, chile       2.200, huevo       6.250, azucar      2.100
      pan         5.588, atun       15.714, pollo      15.000, res        12.400 /
;

* Costos por 100 ml bebidas
Parameter g(j)
    / agua        0.050, leche       2.800, cafe       12.000
      saborizante 5.000, refresco    1.200 /
;


* Poblacion
Scalar h_adultos / 67 /;
Scalar h_ninos / 33 /;



* Z = costo semanal total
Variables z;

Positive Variables
* x: alimentos diarios por persona en gramos
* y: bebidas diarias por persona al dia en mililitros
    x(i)
    y(j)
;


Equations
* Ecuaciones independientes para evaluar cada grupo con su poblacion
    obj_adultos
    nut_adultos(l)
    disp_alimento_adultos(i)
    disp_bebida_adultos(j)
    var_alimento_adultos(i)

    obj_ninos
    nut_ninos(l)
    disp_alimento_ninos(i)
    disp_bebida_ninos(j)
    var_alimento_ninos(i)
;


* Restricciones de adultos -------------------------------------------------------------------------------
*Costo semanal: dias * cantidad personas * costo alimentos * costo bebidas
obj_adultos ..
    z =e= 7 * h_adultos * (sum(i, f(i) * x(i) / 100) + sum(j, g(j) * y(j) / 100));

* Aporte nutricional de alimentos + bebidas > = requerimientos minimos
nut_adultos(l) ..
    sum(i, a(i,l) * x(i) / 100) + sum(j, b(j,l) * y(j) / 100) =g= d('adultos', l);

* Cantidad semanal de alimentos/bebidas por semana es menor que la disponiblidad de alimento/bebida
disp_alimento_adultos(i) ..  7 * h_adultos * x(i) =l= c(i);
disp_bebida_adultos(j) ..    7 * h_adultos * y(j) =l= e(j);

* La cantdad maxima de un alimento especifico no puede aportar mas del 10 porcentiento de la dieta
var_alimento_adultos(i) ..   x(i) - 0.10 * sum(ii, x(ii)) =l= 0;


*Restricciones de kids ------------------- ---------------------------------------------------------------

* Costo semanal: dias * cantidad personas * costo alimentos * costo bebidas
obj_ninos ..
    z =e= 7 * h_ninos * (sum(i, f(i) * x(i) / 100) + sum(j, g(j) * y(j) / 100));

* Aporte nutricional de alimentos + bebidas > = requerimientos minimos
nut_ninos(l) ..
    sum(i, a(i,l) * x(i) / 100) + sum(j, b(j,l) * y(j) / 100) =g= d('ninos', l);

* Cantidad semanal de alimentos/bebidas por semana es menor que la disponiblidad de alimento/bebida
disp_alimento_ninos(i) ..  7 * h_ninos * x(i) =l= c(i);
disp_bebida_ninos(j) ..    7 * h_ninos * y(j) =l= e(j);

* La cantdad maxima de un alimento especifico no puede aportar mas del 10 porcentiento de la dieta
var_alimento_ninos(i) ..   x(i) - 0.10 * sum(ii, x(ii)) =l= 0;



Model modelo_adultos / obj_adultos, nut_adultos, disp_alimento_adultos, disp_bebida_adultos, var_alimento_adultos /;
Model modelo_ninos   / obj_ninos,   nut_ninos,   disp_alimento_ninos,   disp_bebida_ninos,   var_alimento_ninos /;



Parameter Costo_Total_Adulto;
Parameter Macros_Totales_Adultos(l);
Parameter Alimento_Cant_Adultos(i);
Parameter Bebida_Cant_Adultos(j);
Parameter Costo_x_Alimento_Adultos(i);
Parameter Costo_x_Bebida_Adultos(j);

Parameter Costo_Total_Nino;
Parameter Macros_Totales_Ninos(l);
Parameter Alimento_Cant_Ninos(i);
Parameter Bebida_Cant_Ninos(j);
Parameter Costo_x_Alimento_Ninos(i);
Parameter Costo_x_Bebida_Ninos(j);



* MODELO ADULTOS -------------

Solve modelo_adultos using lp minimizing z;

Costo_Total_Adulto           = sum(i, f(i) * x.l(i) / 100) + sum(j, g(j) * y.l(j) / 100);
Macros_Totales_Adultos(l)    = sum(i, a(i,l) * x.l(i) / 100) + sum(j, b(j,l) * y.l(j) / 100);
Alimento_Cant_Adultos(i)     = x.l(i);
Bebida_Cant_Adultos(j)       = y.l(j);
Costo_x_Alimento_Adultos(i)  = f(i) * x.l(i) / 100;
Costo_x_Bebida_Adultos(j)    = g(j) * y.l(j) / 100;


* MODELO NINOS -------------

Solve modelo_ninos using lp minimizing z;

Costo_Total_Nino           = sum(i, f(i) * x.l(i) / 100) + sum(j, g(j) * y.l(j) / 100);
Macros_Totales_Ninos(l)    = sum(i, a(i,l) * x.l(i) / 100) + sum(j, b(j,l) * y.l(j) / 100);
Alimento_Cant_Ninos(i)     = x.l(i);
Bebida_Cant_Ninos(j)       = y.l(j);
Costo_x_Alimento_Ninos(i)  = f(i) * x.l(i) / 100;
Costo_x_Bebida_Ninos(j)    = g(j) * y.l(j) / 100;


* Display

Display "===========================================================";
Display "                      == ADULTOS ==                        ";
Display "===========================================================";

Display Costo_Total_Adulto;
Display Macros_Totales_Adultos;
Display Alimento_Cant_Adultos;
Display Bebida_Cant_Adultos;
Display Costo_x_Alimento_Adultos;
Display Costo_x_Bebida_Adultos;

Display " ";
Display " ";
Display " ";

Display "===========================================================";
Display "                       == NINOS ==                         ";
Display "===========================================================";

Display Costo_Total_Nino;
Display Macros_Totales_Ninos;
Display Alimento_Cant_Ninos;
Display Bebida_Cant_Ninos;
Display Costo_x_Alimento_Ninos;
Display Costo_x_Bebida_Ninos;