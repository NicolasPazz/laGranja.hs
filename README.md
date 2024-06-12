# La Granja

En una granja viven animales, de los cuales registramos su nombre, el tipo de animal, el peso, la edad y sabemos si está enfermo, lo cual podrá requerir una visita médica de alguna persona veterinaria, que diagnostica los días de recuperación y le cobra un costo por la atención.


## Punto 1: Animales sueltos
### La pasó mal
Queremos saber si un animal la pasó mal, esto implica que alguna de las visitas médicas que le hicieron le implicó más de 30 días de recuperación. 

### Nombre falopa
Queremos saber si un animal tiene un nombre falopa, esto pasa si la última letra termina en 'i'. Por ejemplo, "gachi" o "pachi" además de ser de sagitario, tienen un nombre falopa. "Dorothy" no tiene un nombre falopa.
En este punto no puede utilizar funciones auxiliares ni recursividad, solo composición y aplicación parcial.


## Punto 2: Actividades
Queremos modelar las actividades que se hacen en la granja, entre las cuales están

### Engorde
Le dan de comer al animal "x" kilos de alimento balanceado, con lo cual incrementan la mitad de su peso hasta un máximo de 5 kilos. Por ejemplo: si a la vaca Dorothy que pesa 690 kilos le damos de comer 12 kilos de alimento balanceado, pasará a pesar 695 kilos. Si le damos 4 kilos, pesará 692.

### Revisación
Si el animal está enfermo, se le registra una visita médica anotando los días de recuperación y el costo. Además, al darle vitaminas, eso equivaldría a que el animal coma 2 kilos de alimento balanceado. Consejo: evite repetir ideas.

### Festejo cumple
Le agrega un año más y también se le hace una fiestita, por la emoción el animal pierde un kilo.

### Chequeo de peso
Queremos registrar si un animal está bien de peso, para lo cual tiene que estar por arriba de un peso "x", en caso contrario el animal debe quedar enfermo.


## Punto 3: El proceso
Queremos modelar un proceso, que realiza una serie de actividades sobre un animal. Se pide que además muestre un ejemplo de cómo podría evaluar por consola el proceso para cada una de las actividades resueltas en el punto anterior.
En este punto no puede utilizar funciones auxiliares ni recursividad, solo composición y aplicación parcial.


## Punto 4: ¿Mejora o no mejora?
Dado un proceso (lista de actividades) y un animal, queremos saber si el animal mejora sustentablemente el peso, esto implica que el peso nunca debe bajar de una actividad a otra y tampoco debe subir más de 3 kilos de una actividad. 
Este punto debe resolverlo con recursividad.


## Punto 5: Give me one, give me two... 
Queremos obtener los primeros tres animales que tengan un nombre falopa. Resolverlo solo con funciones de orden superior.
Si le pasáramos una cantidad infinita de animales, sería posible obtener un valor computable para la función del punto anterior? Justifique su respuesta relacionándolo con un concepto visto en la materia.