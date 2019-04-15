% Gloppi Ya
% Ignacio E. Losiggio, Federico A. Sabatini

# Estructura

Este trabajo práctico está construído con una colección de scripts y archivos
tal que de no tener más que el código un simple `make` realice toda la
experimentación, gráficos y construya el informe a entregar.

La estructura de archivos y carpetas es la siguiente:

Makefile
: Las reglas de construcción de todo el proyecto

README.md
: Éste archivo (o el que genera la página que se obtiene al correr `make help`

main.cpp algos.h
: Definiciones usadas por todos los algoritmos

mochila.tex
: Fuente del informe

algos/\<algoritmo\>.cpp
: Algoritmos implementados

casos/\<caso\>.in casos/\<caso\>.out
: Casos de prueba, cada uno consta de dos archivos **\<experimento\>.in** (la
  entrada del algoritmo) y **\<experimento\>.out**. Estos archivos pueden
  generarse con los scripts _generar\_casos.sh_, _generar\_experimentacion.sh_
  que construyen las entradas y _completar\_casos.sh_ que las soluciona.

data/\<caso\>.\<algoritmo\>.resultados
: Experimentación conseguida, estos archivos son las salidas utilizadas en
  nuestro informe. Pueden generarse nuevos eliminándolos y utlizando la flag
  **TEST=y** al correr `make`.

data/\<caso\>.\<algoritmo\>.stats data/exp.\<experimento\>.\<algoritmo\>.series
: Información estadística construída en base a los resultados. 

fotos/\*.pdf
: Imágenes generadas.

scripts/
: Pequeños programas usados para graficar, generar casos de prueba y
  experimentar.

.gitignore
: Lista de archivos a ignorar en el control de versiones.

# Requisitos y software utilizado

En la confección de este trabajo se usó una gran cantidad de software que se
requiere para construir el proyecto, en caso de un fallo ésta es la lista:

* bash (cualquier shell POSIX debería servir)
* AWK
* Gnuplot
* graphviz
* GCC (g++, no toda la suite)
* GNU Coreutils
* GNU Make
* LaTeX (nos gustaría poder indicar cuáles paquetes, pero la lista es inmensa,
  una distribución relativamente completa como _texlive-full_ en Ubuntu debería
  alcanzar).
* latexmk
* Pandoc (necesario para construir este manual como página de **man(1)**)

# Targets del Makefile 

Si bien el protecto está dieñado para que el correr `make` sea suficiente para
generar todo, puede resultar molesto para la reconstrucción de pequeñas partes
(testear gráficos nuevos por ejemplo). Por lo que en esta sección describiremos
superficialmente su funcionamiento y algunos de los targets que pueden resultar
útiles.

El proyecto se divide en 2 Makefiles, el principal (fotos, binarios, informe y
testeo informal) y el de experimentación (_casos/Makefile_) que posee ciertas
variables configurables para realizar nuevas experimentaciones.

## Organización

El Makefile principal está organizado en 3 secciones y hace uso y abuso de las
capacidades de **GNU Make** (`foreach`, `wildcard`, etc).

## Ejecutables

Una de las primeras cosas a la vista es que todos los algoritmos comparten el
fichero **main.cpp**, el cuál lee la entrada estándar, construye una
representación simple del mismo en memoria y llama a la función **mochila**
correspondiente. Sumado a ésto, la mitad de los algoritmos poseen una variante
“Gráfica” la cuál imprime la información necesaria para reconstruir el árbol de
ejecución del mismo.

```console
# Ejemplo: construir los árboles de ejecución de los algoritmos recursivos
#          en el caso de prueba pdf.in
$ make fotos/pdf.{dinamica,fact,opt}.pdf
```

## Targets útiles

make all
: Construye todo el proyecto, si no hay experimentación hecha la realiza.

make \<nombre\>.test
: Corre el test indicado en todos los algoritmos.

make help
: Muestra esta ayuda.

make clean
: Limpia los archivos intermedios (excepto los .resultado de la
  experimentación).

make \<archivo\>
: Construye ese fichero y sus dependencias.

## Experimentación

Cómo fué dicho anteriormente, la experimentación se basa en extraer información
estadística de los ficheros **data/\<caso\>.\<algoritmo\>.resultado**. Por el
momento extraemos la suma total de tiempo incurrido, el promedio y la
desviación estándar con el script __stats.awk__ y la almacenamos en el archivo
**data/\<caso\>.\<algoritmo\>.stats** correspondiente. Un target del Makefile de
experimentación unifica todos estos ficheros en un archivo
**data/exp.\<experimento\>.\<algoritmo\>.series** junto a información sobre cada
caso de prueba que hayamos creído necesaria para el análisis.

Parte de la simpleza de nuestro sistema de experimentación es que la forma en
que distinguimos la información de un caso de prueba que usamos para pruebas
pequeñas (por ejemplo _pdf_, el test ofrecido en el enunciado de la cátedra)
de las de la experimentación es por el nombre. Un caso de prueba de un
experimento tiene la forma **exp.\<experimento\>.\<número\>**.

El Makefile de experimentación tiene varios parámetros configurables. Dado que
en nuestra experimentación tuvimos un tiempo máximo que podía tardar un caso de
prueba una tarea posible es (con una computadora poderosa) volver a correr
nuestros experimentos con un límite de tiempo más alto y una mayor cantidad de
veces por cada caso.

```console
# Ejemplo: volver a correr el experimento C
$ cd data/
$ rm exp.c.dinamica.{series,stats,resultados}
$ make veces=250 timeout=60 exp.c.dinamica.series
```

# Scripts

En la carpeta de scripts se encuentran una gran cantidad de scripts. No todos
se utilizan para la construcción del proyecto, algunos son resultado de previos
sistemas para testear nuestros algoritmos y visualizarlos. Otros son ideas que
nos gustó mantener en el respositorio. Ofrecemos una lista con una breve
descripción de cada uno.

completar_casos.sh [-h] [carpeta] [algoritmo]
: Completa los casos sin salidas confirmadas, posee el flag **-h** que ofrece
  una pequeña ayuda.

experimento_a.plot \<series\> \<salida\> \<cota\>
: Construye los gráficos del experimento A. La cota es pasada como parámetro y
  puede utilizar las variables **n**, **W** y **k** (para la constante sobre la
  cual hacer el best-fit).

experimento_b.plot \<series\> \<salida\>
: Construye los _pseudo_-heatmaps del experimento B.

experimento_c.plot
: Construye los gráficos del experimento C. 

experimento_a_correlacion.plot \<series\> \<salida\> \<cota\>
: Construye un gráfico de “Tiempo Real vs. Cota”. La cota es pasada como
  parámetro y utiliza los archivos de series del experimento A y C. Este
  gráfico no se usó en el informe.

experimento_correlacion_dinamica.plot
: Construye un gráfico de “Tiempo Real vs. Cota” del algoritmo de programación
  dinámica. Este script existe porque *experimento_a_correlacion.plot* no
  soportaba que la cota use a **W** (podría haberse reparado).

generar_a.awk [-v seed=\<seed\>] [-v n=\<n\>]
: Imprime un caso de prueba para el experimento A.

generar_b.awk [-v seed=\<seed\>] [-v n=\<n\>]
: Imprime un caso de prueba para el experimento B.

generar_c.awk [-v seed=\<seed\>]
: Imprime un caso de prueba para el experimento C.

generar_casos.awk [-v seed=\<seed\>] [-v n=\<n\>] [-v w=\<w\>] [-v p_piso=\<p_piso\>] [-v p_techo=\<p_techo\>] [-v v_piso=\<v_piso\>] [-v v_techo=\<v_techo\>]
: Genera un caso de prueba según los parámetros dados (posee defaults para cada
  uno).

generar_casos.sh \<cantidad\> \<prefijo\> [sufijo]
: Genera una batería de tests con _generar\_casos.awk_. Los parámetros
  determinan los nombres y la batería en sí (dado que se usa el nombre cómo
  parte del seed).

generar_experimentacion.sh
: Genera la experimentación, debería generar siempre la misma dado que los
  seeds están hardcodeados.

run_test.sh \<caso\> \<ejecutable\> \<veces\> \<timeout\>
: Corre un test n veces con el timeout elegido. Si el test tiemoutea no se lo
  reintenta y se imprime **Timeout**

stats.awk
: Calcula la suma total, media muestral y desviación estándar muestral de un
  archivo con formato .series leído de la entrada estándar

# Formatos

Todos los formatos intermedios son formatos simples separados por espacios y
todos los tiempos figuran en milisegundos. Pasamos a documentarlos.

## Resultados (data/\<caso\>.\<algoritmo\>.resultados)

El formato de estos archivos está delimitado por espacios, tiene una línea por
corrida y posee las siguientes columnas:

>+-----------+--------+--------+
>| Algoritmo | Salida | Tiempo |
>+-----------+--------+--------+

En caso de que el algoritmo haya timeouteado la línea “Timeout” será la última
del fichero

## Stats (data/\<caso\>\<algoritmo\>.stats)

Éstos ficheros son generados por _scripts/stats.awk_.

>+----------+----------------------+-----------------+---------------------+
>| Corridas | Tiempo total gastado | Tiempo promedio | Desviación estándar |
>+----------+----------------------+-----------------+---------------------+

En caso de que el algoritmo haya timeouteado el archivo se verá de la siguiente
forma:

> 0 99999 99999 99999

## Series (data/exp.\<experimento\>.\<algoritmo\>.series)

Las series son distintas de acuerdo a cada experimento, dado que originalmente
pensamos en realizar un montón de análisis distintos que no pudimos concretar.

### Experimento A y B

Estas series usan **n** y **W** (en el caso del experimento A **W** se utiliza
únicamente para intentar construír la función de best-fit de dinámica, lo que
fué un fracaso).

>+---+---+-----------------+---------------------+
>| n | W | Tiempo promedio | Desviación estándar |
>+---+---+-----------------+---------------------+

### Experimento C

Esta serie es sólo para analizar a dinámica y cómo **n** es igual a **W** se lo
omite.

>+---+-----------------+---------------------+
>| n | Tiempo promedio | Desviación estándar |
>+---+-----------------+---------------------+
