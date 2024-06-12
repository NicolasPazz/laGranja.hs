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
    diasDeRecuperacion :: [Number],
    gastosGenerados :: [Number]
} deriving (Show)

type Actividad = Animal -> Animal

laPasoMal :: Animal -> Bool
laPasoMal = any (>30) . diasDeRecuperacion

nombreFalopa :: Animal -> Bool
nombreFalopa = (=='i') . last . nombre

engorde :: Number -> Actividad
engorde kilos animal = animal {peso = peso animal + min 5 (kilos / 2)}

revisacion :: Number -> Number -> Actividad
revisacion dias costo animal    |   enfermo animal = engorde 2 (animal { diasDeRecuperacion = dias  : diasDeRecuperacion animal,
                                                                        gastosGenerados    = costo : gastosGenerados animal})
                                |   otherwise = animal

festejoCumple :: Actividad
festejoCumple animal = animal {edad = edad animal + 1,
                               peso = peso animal - 1}

chequeoDePeso :: Number -> Actividad
chequeoDePeso pesoMinimo animal | peso animal <= pesoMinimo = animal {enfermo = True}    
                                | otherwise = animal

proceso :: [Actividad] -> Animal -> Animal
proceso actividades animal = foldl (flip ($)) animal actividades

-- Ejemplo de evaluación por consola
-- proceso [engorde 10, revisacion 5 100, festejoCumple, chequeoDePeso 10] (Animal "Pepito" "Perro" 10 5 False [] [])

mejora :: [Actividad] -> Animal -> Bool
mejora [] _ = True
mejora [actividad1] _ = True
mejora (actividad1:actividad2:actividades) animal = peso (actividad2 animal) >= peso (actividad1 animal) && peso (actividad2 animal) - peso (actividad1 animal) <= 3 && mejora (actividad2:actividades) (actividad1 animal)

animalesFalopa :: [Animal] -> [Animal]
animalesFalopa = take 3 . filter nombreFalopa

--Sería posible obtener un valor computable para la función del punto anterior, ya que la función take 3 terminaría de ejecutarse cuando encuentre 3 nombres de animales que cumplan con el criterio de filter. Esto se relaciona con el concepto de evaluación perezosa, ya que Haskell no evalúa la lista completa, sino que va evaluando los elementos de la lista a medida que los necesita. En el caso que nunca encuentre 3 nombres de animales que cumplan con el criterio de filter, la función no terminaría de ejecutarse.