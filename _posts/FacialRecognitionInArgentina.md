---
layout: post
title: Reconocimiento facial en Argentina | Facial recognition in Argentina
tags: [Operations-Research]
---

En el 2019, el gobierno de la Ciudad de Buenos Aires incorporó
a su red de vigilancia cámaras con \textit{facial recognition}. A través de un
convenio con el Renaper, se supone que el sistema tendría acceso a los datos
biométricos de aquellos individuos  registrados en la CONARC o con alguna orden
judicial en su contra. En total, unos 40.000 individuos. El propósito oficial:
la protección de ciudadanos y familias de los delincuentes que siguen libres.

Sólo un año después, tras una serie de pericias, desencadenadas por una acción
de amparo iniciada por ODIA, se descubrió que las fuerzas policiales habían
utilizado los datos de casi 10 millones de ciudadanos. Se constató además lo que
esta cifra hace evidente: que se habían vulnerado los datos biométricos de un
inmenso número de ciudadanos no registrados en la CONARC ni con órdenes
judiciales en su contra. Entre los individuos vulnerados, aparte de innumerables
"civiles ordinarios", se encontraban figuras de trascendencia pública. Ejemplos
de interés son la actual vicepresidente Cristina Fernández, el presidente
Alberto Fernández, y Estela de Carlotto. Jueces, fiscales y dirigentes sociales
se encuentran en el listado de individuos vulnerados.

El contexto en el que se produjo esta vulneración no es claro. La ausencia de
mecanismos de control, supervisión y transparencia, el vacío legal ocasionado
por la falta de regulaciones en la nueva tecnología, hicieron imposible
determinar el nivel de responsabilidad atribuible a los distintos actores ---las
diferentes esferas del poder ejecutivo por un lado, las fuerzas policiales por
otro---. La Corte Suprema acabó por determinar la inconstitucionalidad del
sistema de vigilancia y su sucesiva desarticulación. 

La violación, que era digna de un escándalo, aunque cubierta por varios medios
internacionales, fue ignorada en el periodismo nacional. La población, por lo
general, permanece en pleno desconocimiento del problema. Acaso por esta razón
el fallo de la corte fue de corto vuelo: ante la crisis en Rosario, el gobierno
nacional avisa ---una vez más, en nombre del cuidado de sus ciudadanos--- que
instalará centenares de estas cámaras en la ciudad afectada. 

Aunque la forma y la intensidad de la vigilancia son una función de la
ideología, variando de un gobierno a otro, su existencia no lo es. El uso de
\textit{facial recognition} está en el interés de cualquier gobierno ---es
acorde a la naturaleza del Estado. Por eso vemos un gobierno moderadamente
progresista repetir el error de su antecesor de derecha. Y aunque es
particularmente aterrador imaginar esta tecnología en manos de, digamos, una
dictadura militar, su existencia en manos del más amable de los gobiernos ya
constituye una ofensa a \textit{principios} elementales, por un lado, y una
fuente de \textit{consecuencias} perniciosas, por otro. Para ponerlo de otro
modo, la oposición al uso de tales tecnologías es tanto \textit{a matter of
fact} como \textit{a matter of principle}. Por lo pronto, deseo enfocarme en lo 
primero.

El primer problema, de naturaleza tecnológica, es
curiosamente simple. El reconocimiento facial es realizado a través de redes
neuronales. Asumamos que la tasa de error de la red utilizada es óptimo; por
ejemplo, que los falsos positivos constituyen el $0.01 \%$ de las observaciones.
Semejante tasa, que supera toda expectativa, al menos en el estado actual de
desarrollo tecnológico, sólo puede celebrarse allí donde los falsos positivos
son relativamente inconscecuentes, o la cantidad de observaciones relativamente
pequeña. La identificación de prófugos o personas de interés a través de tales
tecnologías no satisface ninguna de estas dos condiciones. Más de 1.3 millones
de personas utilizan ---por tomar un ejemplo fácil--- el subterráneo porteño
diaraiamente. La tasa que hemos supuesto nos garantiza, en este caso, una
esperanza de $\approx 130$ falsos positivos diarios; es decir, alrededor de 130
personas detenidas erróneamente de manera diaria. Queda por determinar si el
costo compensa los benificios, incluso donde se asuma un uso adecuado del
sistema por parte del Estado. Mi respuesta tentativa es que no.

Corresponde señalar que el gobierno argentino declaró, en principio, una tasa
de error del 4$\%$ (!). No dio información respecto a la proporción de falsos
positivos y falsos negativos que componen ese total. En cualquier caso, según
lo investigado por el NIST, en Estados Unidos, el caso general para las
tecnologías de reconocimiento facial es una preponderancia de los falsos
positivos sobre los falsos negativos, y no hay razón para asumir que el sistema
argentino fuera una excepción. Más aún, según reportó el gobierno al ODIA,
hacia finales de 2019, sólo 1648 de 3059 alertas fueron correctas. De esto se
deduce el paupérrimo porcentaje de efectividad de 53.85$\%$, con 1500 personas
investigadas o detenidas sin justificación alguna en sólo algunos meses de
funcionamiento del sistema.

Las investigaciones del NIST también revelaron que la tasa de error de los
sistemas de reconocimiento facial aumenta considerablemente cuando se pretende
identificar individuos negros, asiáticos, o mujeres. Uno podría asumir que esta
disparidad es consecuencia de una muestra de entrenamiento sesgada, y por lo
tanto concluir que el uso de muestras de entrenamiento más diversas resolvería
el problema. Si esto fuera cierto, en efecto, la cuestión desaparecería. Pero es
probable que nos enfrentemos a un problema diferente, relativo no a las muestras
de entrenamiento con que la red aprende a distinguir patrones biométricos, sino
con la muestra de sujetos que se pretende identificar. 

La distribución de la criminalidad, la probabilidad de que un individuo se vea
forzado o tentado a delinquir, no es idéntica de un grupo social a otro. En la
medida en que los sectores maś desfavorecidos de la sociedad estén racializados,
como de hecho lo están en Argentina, la muestra de sujetos que pretende
identificarse ---los criminales de los que se supone que la red de vigilancia
nos protege--- será relativamente homogénea. La consecuencia directa de esto es
que, con toda probabilidad, los falsos positivos recaerán principalmente sobre
personas también pertenecientes a los sectores más desfavorecidos de la
sociedad. En otras palabras, incluso con una muestra de entrenamiento no
sesgada, la muestra de identificación necesariamente acaba por introducir segos
de raza o clase. En definitiva, se automatiza la detección del crimen de
portación de cara.


Un tercer problema deriva del hecho de que el software que lleva a cabo el
proceso de identificación es implementado, pero no desarrollado, por el Estado.
En el caso de Argentina, los proveedores son, en las distintas provincias,
diferentes empresas privadas. Entre las empresas prestadoras se encuentran
DANAIDE SA, que parece haber estado involucrada en un caso de espionaje contra
Cristina Fernández ---la causa fue desestimada por Bonadío---, y la empresa
francesa IDEMIA (antes llamada Morpho Safran), criticada por Amnistía
Internacional por exportar información a China. 

En cualquier caso, el problema no reside en la integridad o corrupción de una u
otra compañía. El centro de la cuestión está en que la vigilancia es
implementada por software privativo; es decir, por software cuyo código fuente no
puede leerse, modificarse ni distribuirse libremente. Esto significa que cuando
el Estado nacional contrata la prestación del software, el Estado mismo no
conoce, ni puede conocer, lo que el software hace. Esto es irrelevante a los
intereses del Estado, en la medida en que la prestación provea la vigilancia
deseada, pero conforma un nuevo nivel de vulneración de los derechos civiles. En
la medida en que no existe transparencia respecto a qué operaciones son
realizadas \textit{sub rosa} por el software, la ciudadanía está a merced no
sólo del uso que haga el Estado de la parte del sistema que sí puede manipular,
sino del uso que hagan las compañías de aquella que sólo ellas pueden conocer.


Algunas de las cuestiones de principio ---uno quisiera creer--- son
autoevidentes, o por lo menos más accesibles al público general. Me refiero a la
vulneración del derecho a la privacidad, a la cirulación libre, a la presunción
de inocencia, etc. Estos derechos, a mi criterio, están fuera de debate. Otras
cuestiones de principio son más espinosas, y se refieren a problemas como la
naturaleza del Estado, hasta qué punto ciertas regulaciones podrían convertir en
digno de existir al sistema, o si corresponde implementarlo en circunstancias
especiales ---por ejemplo, en cruces aduaneros o aeropuertos internacionales---.
No es mi interés discutirlas ahora. La descripción dada de los problema
concernientes a la implementación de sistemas de reconocimiento facial en la vía
pública debería bastar para convencer a un ciudadano cualquiera de la magnitud
del problema.


