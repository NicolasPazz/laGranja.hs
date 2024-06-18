module Library where
import PdePreludat
import Test.Hspec.Runner (Config(configPrintSlowItems))

doble :: Number -> Number
doble numero = numero + numero

data Animal = Animal {
    nombre :: String,
    tipo :: String,
    peso :: Number,
    edad :: Number,
    enfermo :: Bool,
    visitasMedicas :: [VisitaMedica]
} deriving (Show, Eq)

data VisitaMedica = VisitaMedica{
    diasDeRecuperacion :: Number,
    costo :: Number
} deriving (Show, Eq)

type Actividad = Animal -> Animal

laPasoMal :: Animal -> Bool
laPasoMal = any ((>30) . diasDeRecuperacion) . visitasMedicas

nombreFalopa :: Animal -> Bool
nombreFalopa = (=='i') . last . nombre

--AUX
modificarPeso :: Number -> Actividad
modificarPeso kilos animal = animal {
    peso = peso animal + kilos
}

engorde :: Number -> Actividad
engorde kilos = modificarPeso (5 `min` (kilos / 2))

revisacion :: VisitaMedica -> Actividad
revisacion visita animal    |   enfermo animal = engorde 2 (animal {visitasMedicas = visita : visitasMedicas animal})
                            |   otherwise = animal

festejoCumple :: Actividad
festejoCumple animal = modificarPeso (-1) animal {edad = edad animal + 1}

chequeoDePeso :: Number -> Actividad
chequeoDePeso pesoMinimo animal = animal {enfermo = peso animal <= pesoMinimo}

type Proceso = [Actividad]

proceso :: Proceso -> Animal -> Animal
proceso actividades animal = foldl (flip ($)) animal actividades

-- Ejemplo de evaluación por consola
-- > proceso [engorde 10, revisacion (visitaMedica 24), festejoCumple, chequeoDePeso 10] (Animal "Pepito" "Perro" 10 5 False [])

mejora :: Proceso -> Animal -> Bool
mejora [] _ = True
mejora [actividad1] _ = True
mejora (actividad1:actividad2:actividades) animal = peso (actividad2 animal) >= peso (actividad1 animal) && peso (actividad2 animal) - peso (actividad1 animal) <= 3 && mejora (actividad2:actividades) (actividad1 animal)

animalesFalopa :: [Animal] -> [Animal]
animalesFalopa = take 3 . filter nombreFalopa

--Es posible obtener un valor para la función del punto anterior, ya que la función take 3 terminaría de ejecutarse cuando encuentre 3 nombres de animales que cumplan con el criterio de filter, en este caso se dice que la lista converge. Esto se relaciona con el concepto de Lazy Evaluation. Haskell no evalúa la lista completa, sino que va evaluando los elementos de la lista a medida que los necesita. En el caso que nunca encuentre 3 nombres de animales que cumplan con el criterio de filter, la función no terminaría de ejecutarse y llenaria la memoria.