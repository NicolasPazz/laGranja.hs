module Spec where
import PdePreludat
import Library
import Test.Hspec

animal1 = Animal {
  nombre = "Pepito",
  tipo = "Perro",
  peso = 10,
  edad = 5,
  enfermo = False,
  diasDeRecuperacion = [],
  gastosGenerados = []
}
animal2 = Animal {
  nombre = "Luna",
  tipo = "Gato",
  peso = 8,
  edad = 3,
  enfermo = True,
  diasDeRecuperacion = [10],
  gastosGenerados = [20]
}
animal3 = Animal {
  nombre = "Kiwi",
  tipo = "Ave",
  peso = 5,
  edad = 2,
  enfermo = False,
  diasDeRecuperacion = [15, 25, 35],
  gastosGenerados = []
}
animal4 = Animal {
  nombre = "Tommy",
  tipo = "Tortuga",
  peso = 12,
  edad = 100,
  enfermo = True,
  diasDeRecuperacion = [40, 50],
  gastosGenerados = [100, 200]
}

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test" $ do  
        it "doble de un número" $ do
            doble 2 `shouldBe` 4
            doble (-1) `shouldBe` (-2)
        
        it "animal la pasa mal si tiene días de recuperación mayor a 30" $ do
            laPasoMal animal1 `shouldBe` False
            laPasoMal animal3 `shouldBe` True
            laPasoMal animal4 `shouldBe` True

        it "animal con nombre falopa" $ do
            nombreFalopa animal1 `shouldBe` False
            nombreFalopa animal2 `shouldBe` False
            nombreFalopa animal3 `shouldBe` True
        
        it "engorde de un animal" $ do
            let animalEngordado = engorde 10 animal1
            peso animalEngordado `shouldBe` 15 -- 10 + min 5 (10 / 2) = 15

        it "revisacion de un animal enfermo" $ do
            let animalRevisado = revisacion 5 100 animal2
            diasDeRecuperacion animalRevisado `shouldBe` [5, 10]
            gastosGenerados animalRevisado `shouldBe` [100, 20]
            peso animalRevisado `shouldBe` 9
        
        it "festejo de cumpleaños de un animal" $ do
            let animalCumple = festejoCumple animal1
            edad animalCumple `shouldBe` 6
            peso animalCumple `shouldBe` 9 -- 10 - 1 = 9
        
        it "chequeo de peso de un animal" $ do
            let animalChequeado = chequeoDePeso 10 animal1
            enfermo animalChequeado `shouldBe` True
            
            let animalChequeado2 = chequeoDePeso 15 animal1
            enfermo animalChequeado2 `shouldBe` True

        it "mejora de un animal con actividades" $ do
            mejora [engorde 10, engorde 5] animal1 `shouldBe` False 
            mejora [engorde 10, engorde 20] animal1 `shouldBe` True

        it "animal la pasa mal si tiene días de recuperación mayor a 30" $ do
            laPasoMal animal1 `shouldBe` False
            laPasoMal animal3 `shouldBe` True
            laPasoMal animal4 `shouldBe` True

        it "animal con nombre falopa" $ do
            nombreFalopa animal1 `shouldBe` False
            nombreFalopa animal2 `shouldBe` False
            nombreFalopa animal3 `shouldBe` True
        
        it "engorde de un animal" $ do
            let animalEngordado = engorde 10 animal1
            peso animalEngordado `shouldBe` 15 -- 10 + min 5 (10 / 2) = 15
        
        it "festejo de cumpleaños de un animal" $ do
            let animalCumple = festejoCumple animal1
            edad animalCumple `shouldBe` 6
            peso animalCumple `shouldBe` 9 -- 10 - 1 = 9

        it "animal la pasa mal si tiene días de recuperación mayor a 30" $ do
            laPasoMal animal1 `shouldBe` False
            laPasoMal animal3 `shouldBe` True
            laPasoMal animal4 `shouldBe` True

        it "animal con nombre falopa" $ do
            nombreFalopa animal1 `shouldBe` False
            nombreFalopa animal2 `shouldBe` False
            nombreFalopa animal3 `shouldBe` True
        
        it "engorde de un animal" $ do
            let animalEngordado = engorde 10 animal1
            peso animalEngordado `shouldBe` 15 -- 10 + min 5 (10 / 2) = 15
        
        it "festejo de cumpleaños de un animal" $ do
            let animalCumple = festejoCumple animal1
            edad animalCumple `shouldBe` 6
            peso animalCumple `shouldBe` 9 -- 10 - 1 = 9
        
        it "proceso de varias actividades sobre un animal" $ do
            let animalProcesado = proceso [engorde 10, revisacion 5 100, festejoCumple, chequeoDePeso 10] animal1
            peso animalProcesado `shouldBe` 14
            edad animalProcesado `shouldBe` 6
            enfermo animalProcesado `shouldBe` False
            diasDeRecuperacion animalProcesado `shouldBe` []
            gastosGenerados animalProcesado `shouldBe` []