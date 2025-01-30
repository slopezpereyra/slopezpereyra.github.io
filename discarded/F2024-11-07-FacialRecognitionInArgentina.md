---
title: Reconocimiento facial en Argentina
categories: [ Política ]
---

> Toda información cuya fuente no se provea inmediatamente está en alguna de las fuentes 
listadas al final del artículo.

En 2019, el gobierno de la Ciudad de Buenos Aires incorporó a su red de
vigilancia cámaras con reconocimiento facial. Un convenio con el Renaper
estableció que el sistema tendría acceso a los datos biométricos de todos los
individuos registrados en la CONARC. En total, unas $40.000$ personas. Como es
usual, el propósito declarado fue que los "vecinos estén más seguros" (en
palabras de Rodríguez Larreta).

Un año después, una acción de amparo iniciada por [ODIA](https://odia.legal/)
desencadenó una serie de pericias. Se descubrió que las fuerzas policiales
habían consultado, al menos diez millones de veces, los datos de casi 7.5
millones de personas. Se constató además lo que, en todo caso, esta cifra
implica necesariamente: que se habían vulnerado los datos biométricos de un
inmenso número de personas que no estaban en la CONARC. Entre los individuos
vulnerados, aparte de civiles ordinarios, se encontraban diversas figuras de
trascendencia pública. Ejemplos de interés son Cristina Fernández, Alberto
Fernández y Estela de Carlotto. El actual presidente, Javier Milei, por aquel
entonces una caricatura televisiva en auge, es otra víctima. Jueces, fiscales y
dirigentes sociales por igual se encuentran en un [listado de algunos individuos
vulnerados](https://www.mpf.gob.ar/pia/files/2023/04/Expte-228-22-resolucion-difusion-20-4-23.pdf).

El contexto en el que se produjo esta vulneración no es claro. La ausencia de
mecanismos de control, supervisión y transparencia, y el vacío legal ocasionado
por la falta de regulaciones en la nueva tecnología, hicieron imposible
determinar el nivel de responsabilidad atribuible a los distintos actores —las
diferentes esferas del poder ejecutivo por un lado, las fuerzas policiales por
otro—. La Corte Suprema acabó por determinar la inconstitucionalidad del
sistema de vigilancia y su sucesiva desarticulación. La violación, que era
digna de un escándalo, aunque cubierta por varios medios internacionales, fue
ignorada en el periodismo nacional. La población, por lo general, permanece en
pleno desconocimiento del problema. Acaso por esta razón el fallo de la corte
fue de corto vuelo: ante la crisis criminal en Rosario, el gobierno de Alberto Fernández —una
vez más, en nombre del cuidado de sus ciudadanos— instaló centenares de estas
cámaras en la ciudad.

La forma y la intensidad de la vigilancia son una función de la ideología:
varían de un gobierno a otro. Sin embargo, su existencia no lo es. El uso de
sistemas con reconocimiento facial está en el interés de cualquier gobierno—es
acorde a la naturaleza del Estado. Por eso vemos un gobierno moderadamente
progresista repetir el error de su antecesor de derecha. Y aunque es
particularmente aterrador imaginar esta tecnología en manos de, digamos, una
dictadura militar, su existencia en manos del mejor de los gobiernos ya
es una violación de principios elementales. Dicho de otro modo, la oposición al
uso de tales tecnologías es tanto *a matter of fact* como *a matter of
principle*. Por lo pronto, deseo enfocarme en lo primero.

El primer problema, de naturaleza tecnológica, es curiosamente simple. El
reconocimiento facial es realizado a través de redes neuronales. Asumamos un
escenario óptimo: una tasa de falsos positivos de $0.01$%. Es decir, asumamos
que sólo en el $0.01$% de los casos, el rostro de un individuo que *no*
pertenece al grupo que se pretende identificar—en este caso, prófugos—es
identificado como tal. 

Esta tasa, que supera toda expectativa, sería celebrable sólo allí donde los
falsos positivos son relativamente inconscecuentes, o la cantidad de
observaciones relativamente pequeña. La identificación de prófugos no satisface
ninguna de estas dos condiciones. Más de $1.3$ millones de personas utilizan
—por tomar un ejemplo fácil— el subterráneo porteño diariamente. La tasa que
hemos supuesto nos garantiza, en este caso, una esperanza de $\approx 130$
falsos positivos diarios; es decir, alrededor de $130$ personas identificadas
erróneamente de manera diaria. Queda por determinar si el costo compensa los
benificios, incluso donde se asuma un uso adecuado del sistema por parte del
Estado. Mi respuesta tentativa es que no. Y es concebible que Guillermo
Federico Ibarrola, [erróneamente detenido por un falso
positivo](https://www.pagina12.com.ar/209910-seis-dias-arrestado-por-un-error-del-sistema-de-reconocimien),
esté de acuerdo conmigo.

Corresponde señalar que el gobierno argentino declaró, en principio, una tasa
de error del 4% (!). No dio información respecto a la proporción de falsos
positivos y falsos negativos que componen ese total. En cualquier caso, [según
lo investigado por el NIST](https://www.nist.gov/speech-testimony/facial-recognition-technology-part-iii-ensuring-commercial-transparency-accuracy), en Estados Unidos, el caso general para las
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

La distribución de la criminalidad, o bien la probabilidad de que un individuo
se vea forzado o tentado a delinquir, no es idéntica de un grupo social a otro.
En la medida en que los sectores maś desfavorecidos de la sociedad estén
racializados, como de hecho lo están en Argentina, la muestra de sujetos que
pretende identificarse —los criminales de los que se supone que la red de
vigilancia nos protege— será relativamente homogénea. La consecuencia directa
de esto es que, con toda probabilidad, los falsos positivos recaerán
principalmente sobre personas también pertenecientes a dichos sectores. En
otras palabras, incluso con una muestra de entrenamiento no sesgada, la muestra
de identificación necesariamente acaba por introducir segos de raza o clase. En
definitiva, se automatiza la detección del famoso crimen de portación de cara. 
(Este problema se ubica en un contexto discutido por otros en el uso de inteligencia 
artificial; a saber, el curioso surgimiento de una frenología moderna. Véase, 
por ejemplo, [este trabajo](https://www.cell.com/patterns/fulltext/S2666-3899(24)00160-0?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS2666389924001600%3Fshowall%3Dtrue&fbclid=IwY2xjawFaigtleHRuA2FlbQIxMAABHQNTjsLNaCbhUEyfNReAMYOemeZk6eZMnJBz627KUgEJKUET3SAtN2QH4g_aem_IhjU1jVkZm8s92CS4jdNlg) de Mel Andrews).

Un tercer problema deriva del hecho de que el software que lleva a cabo el
proceso de identificación es implementado, pero no desarrollado, por el Estado.
En el caso de Argentina, los proveedores son, en las distintas provincias,
diferentes empresas privadas. Entre las empresas prestadoras se encuentran
DANAIDE SA, que parece haber estado involucrada en un caso de espionaje contra
Cristina Fernández —la causa fue desestimada por Bonadío—, y la empresa
francesa IDEMIA (antes llamada Morpho Safran), criticada por Amnistía
Internacional por exportar información a China. 

En cualquier caso, el problema no reside en la integridad o corrupción de una u
otra compañía. El centro de la cuestión está en que la vigilancia sea
implementada por software privativo; es decir, por software cuyo código fuente no
puede leerse, modificarse ni distribuirse libremente. Esto significa que cuando
el Estado contrata la prestación del software, el Estado mismo no
conoce, ni puede conocer, todo lo que el software hace. Esto es irrelevante a los
intereses del Estado, en la medida en que la prestación provea la vigilancia
deseada, pero conforma un nuevo nivel de vulneración de los derechos civiles. En
la medida en que no existe transparencia respecto a qué operaciones son
realizadas por el software *sub rosa*, la ciudadanía está a merced no
sólo del uso que haga el Estado de la parte del sistema que sí puede manipular,
sino del uso que hagan las compañías de aquella que sólo ellas pueden conocer.


Algunas de las cuestiones de principio —uno quisiera creer— son
autoevidentes, o por lo menos más accesibles al público general. Me refiero a la
vulneración del derecho a la privacidad, a la cirulación libre, a la presunción
de inocencia, etc. Estos derechos, a mi criterio, están fuera de debate. Otras
cuestiones de principio son más espinosas, y se refieren a problemas como la
naturaleza del Estado, hasta qué punto ciertas regulaciones podrían convertir en
digno de existir al sistema, o si corresponde implementarlo en circunstancias
especiales —por ejemplo, en cruces aduaneros o aeropuertos internacionales—.
No es mi interés discutirlas ahora.


--- 

#### Fuentes 

[1](https://www.cels.org.ar/web/2024/02/el-sistema-de-reconocimiento-facial-sigue-suspendido-en-caba/), [2](https://www.cels.org.ar/web/2022/04/el-ministerio-de-seguridad-de-la-ciudad-busco-informacion-biometrica-de-7-millones-de-personas-de-manera-ilegal/), [3](https://buenosaires.gob.ar/jefedegobierno/noticias/horacio-rodriguez-larreta-presento-el-nuevo-sistema-de-reconocimiento-facial), [4](https://www.cels.org.ar/web/2023/04/confirman-la-inconstitucionalidad-del-uso-del-sistema-de-reconocimiento-facial/), [5](https://www.memo.com.ar/runrunes/donaide-camaras-seguridad-mendoza-video-vigilancia/), [6](https://www.alsur.lat/sites/default/files/2021-10/ALSUR_Reconocimiento%20facial%20en%20Latam_ES_Final.pdf)

