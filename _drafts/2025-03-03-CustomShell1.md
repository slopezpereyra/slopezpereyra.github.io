---
title: Aprendiendo Linux programando un intérprete
categories: [Science]
---

Un proyecto lindo para aprender del funcionamiento de bajo nivel de Linux es la
escritura de un intérprete o *shell*. Una shell es una interfaz que admite el
ingreso de comandos por parte del usuario y, en caso de ser válidos, los
ejecuta. Parece una tontería, pero la programación de una shell propia requiere
parsear recursivamente el comando ingresado como un [árbol
binario](https://en.wikipedia.org/wiki/Binary_tree), comprender las (extrañas)
llamadas a sistema que provee el kernel de Linux, como `fork`, `execvp` y
`pipe`, y entender cómo funciona la memoria virtual de un programa, en
particular en lo relativo a sus [descriptores de
archivo](https://en.wikipedia.org/wiki/File_descriptor).

La idea de esta entrada es explicar aspectos básicos del desarrollo de una
shell. Si bien no vamos a desarrollar una shell compleja o con muchas
funcionalidades, la idea es compensar esta falta de amplitud con profundidad.
Trataremos de entender en profundidad los aspectos del sistema operativo que
entra en juego. Así, aunque aprenderemos pocas cosas, las aprendermos bien.

Voy a dividir esta entrada en partes relativameante independientes, y solo más
tarde nos encargaremos de integrar todas ellas. Por supuesto, el desarrollo de
cada parte debe tener en cuenta su futura integración con las demás. Pero
examinar cada aspecto independientemente sin tanta preocupación por su lugar en
el conjunto nos permitirá estudiar algunas cosas más en detalle, como un músico
que estudia a fondo las diversas inversiones de un acorde y sólo después se
preocupa de cómo incorporarlas a una composición.

--- 

# 1: Parsing 

Consideremos un comando `cmd` de tipo `char *`. La shell que desarrollaremos
admitirá no solo la introducción de comandos simples, como `ls` o `rm`, sino
comandos concatenados y pipelines, como `ls -1;rm some_file` y `ls | wc -l`.
Pero es una buena idea presumir, por un momento, que lidiamos con un comando
simple, como `ls`, y no uno compuesto como los que poseen los operadores `;` y
`|`.

Un comando simple se define completamente por el nombre del programa que desea
ejecutar y sus argumentos. Por lo tanto, una forma natural de representar un
comando es un tipo abstracto de datos con campos `type` y `argv`, donde `type`
es el tipo del comando (¿es una pipeline, es un comando simple?) y `argv` es el
vector de argumentos (`argv[0]` es el nombre del programa).

> En Linux, [todo es un
archivo](https://en.wikipedia.org/wiki/Everything_is_a_file), donde por
*archivo* [no debe entenderse necesariamente un conjunto de datos nombrado y
escrito en el disco
duro](https://askubuntu.com/questions/1103937/explain-in-linux-and-unix-everything-is-a-file),
sino una interfaz de lectura/escritura. En otras palabras, los diversos tipos de
datos en Linux tienen una representación común y pueden manipularse con
operaciones semejantes.  
>
> En el caso de los comandos, como `ls`, sucede lo mismo: son archivos, en este
caso en el sentido tradicional, contenidos en `/usr/bin`. Una llamada de `cat`
sobre `/usr/bin` hace evidente que son programas compilados en lenguaje máquina.

Es fácil leer un `cmd` de `STDIN` y construir un comando de tipo ejecutable, es
decir un comando simple.


> STDIN es un flujo de datos estandarizado en los sistemas Unix. 


































