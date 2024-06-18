module Spec where
import PdePreludat
import Library
import Test.Hspec

visita1 = VisitaMedica {
  diasDeRecuperacion = 0,
  costo = 0
}

visita2 = VisitaMedica {
  diasDeRecuperacion = 10,
  costo = 20
}

visita3 = VisitaMedica {
  diasDeRecuperacion = 35,
  costo = 0
}

visita4 = VisitaMedica {
  diasDeRecuperacion = 50,
  costo = 300
}

animal1 = Animal {
  nombre = "Pepito",
  tipo = "Perro",
  peso = 10,
  edad = 5,
  enfermo = False,
  visitasMedicas = [visita1]
}

animal2 = Animal {
  nombre = "Luna",
  tipo = "Gato",
  peso = 8,
  edad = 3,
  enfermo = True,
  visitasMedicas = [visita2]
}

animal3 = Animal {
  nombre = "Kiwi",
  tipo = "Ave",
  peso = 5,
  edad = 2,
  enfermo = False,
  visitasMedicas = [visita3]
}

animal4 = Animal {
  nombre = "Fido",
  tipo = "Perro",
  peso = 15,
  edad = 7,
  enfermo = True,
  visitasMedicas = [visita4]
}

correrTests :: IO ()
correrTests = hspec $ do
  describe "revisacion" $ do  
    it "si el animal está enfermo, se le agrega la visita médica y se le engorda 2 kilos" $ do
      let animal = revisacion visita1 animal2
      peso animal `shouldBe` 9
      visitasMedicas animal `shouldBe` [visita1, visita2]

    it "si el animal no está enfermo, no se le agrega la visita médica" $ do
      let animal = revisacion visita2 animal1
      peso animal `shouldBe` 10
      visitasMedicas animal `shouldBe` [visita1]

  describe "doble" $ do
    it "duplica el valor de un número" $ do
      doble 2 `shouldBe` 4
      doble 5 `shouldBe` 10

  describe "laPasoMal" $ do
    it "devuelve True si alguna visita médica tiene más de 30 días de recuperación" $ do
      laPasoMal animal3 `shouldBe` True
      laPasoMal animal1 `shouldBe` False

  describe "nombreFalopa" $ do
    it "devuelve True si el nombre del animal termina en 'i'" $ do
      nombreFalopa animal3 `shouldBe` True
      nombreFalopa animal1 `shouldBe` False

  describe "modificarPeso" $ do
    it "modifica el peso del animal" $ do
      peso (modificarPeso 3 animal1) `shouldBe` 13
      peso (modificarPeso (-2) animal1) `shouldBe` 8

  describe "engorde" $ do
    it "engorda el animal, aumentando su peso en la mitad de los kilos indicados, hasta un máximo de 5" $ do
      peso (engorde 10 animal1) `shouldBe` 15
      peso (engorde 4 animal1) `shouldBe` 12

  describe "festejoCumple" $ do
    it "incrementa la edad del animal en 1 y reduce su peso en 1" $ do
      let animal = festejoCumple animal1
      edad animal `shouldBe` 6
      peso animal `shouldBe` 9

  describe "chequeoDePeso" $ do
    it "marca al animal como enfermo si su peso es menor o igual al peso mínimo" $ do
      let animal = chequeoDePeso 10 animal1
      enfermo animal `shouldBe` True
      let animal = chequeoDePeso 9 animal1
      enfermo animal `shouldBe` False

  describe "proceso" $ do
    it "aplica una lista de actividades a un animal" $ do
      let animal = proceso [engorde 10, festejoCumple, chequeoDePeso 10] animal1
      peso animal `shouldBe` 14
      edad animal `shouldBe` 6
      enfermo animal `shouldBe` False

  describe "mejora" $ do
    it "devuelve True si cada actividad subsecuente mejora al animal en términos de peso de manera gradual" $ do
      mejora [engorde 10, engorde 2] animal1 `shouldBe` False
      mejora [engorde 10, modificarPeso (-2)] animal1 `shouldBe` False

  describe "animalesFalopa" $ do
    it "devuelve una lista de hasta 3 animales cuyos nombres terminan en 'i'" $ do
      animalesFalopa [animal1, animal2, animal3, animal4] `shouldBe` [animal3]
      animalesFalopa [animal3, animal3, animal3, animal4] `shouldBe` [animal3, animal3, animal3]
