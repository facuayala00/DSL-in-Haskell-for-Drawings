# Laboratorio 1 Paradigmas de la Programación

## Integrantes 
 - Ayala Facundo
 - Bonfils Gastón Tomas
 - Lozano Benjamin

## Experencias con el laboratorio y Haskell
En un principio nos costó bastante entender como funcionaban algunas cosas de haskell, pero fuimos entendiendo sobre la marcha mientras haciamos el laboratorio. 

## Preguntas

### 1. ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.
Las funcionalidades de cada módulo estan separadas para que el programa sea mas legible y entendible. Al poder dividir el código en diferentes partes, se puede entender mejor que hace cada parte del programa y permite una organización de trabajo mas paralela. 
Las responsabilidades de cada módulo eran:
- `Dibujo.hs`: se definen los constructores de nuestro tipo figura y se realiza la declaración de la sintaxis de nuestro lenguaje 
- `Pred.hs`: se definen las funciones que permiten evaluar las propiedades de las figuras
- `Interp.hs`: se define la semántica de nuetro lenguaje, dando una interpretación geométrica de como van a ser nuestras figuras
- `Floatingpic.hs`: se definen algunas funciones de utilidad para el manejo de vectores para poder usar en otros módulos.
- `Grilla.hs`: define una grilla para nuestro lenguaje
- `Escher.hs` y los demas dibujos: definen como se van a dibujar las distintas imagenes que vamos a generar con nuestro lenguaje
- `Main.hs`: parsea los argumentos de entrada y llama a las funciones necesarias para generar las imagenes
- `TestDibujo.hs` y `TestPred.hs`: definen los tests que se van a correr para verificar que los módulos de `Dibujo.hs` y `Pred.hs` funcionen correctamente

### 2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?
Las figuras básicas no se definen en nuestro lenguaje para que el usuario pueda definir sus propias figuras básicas. De esta manera, se pueden generar infinidad de figuras básicas y expande la creatividad del usuario.


### 3. ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
Nos ayuda a escribir mucho menos código. Proporciona una abstracción mas alta y una mayor flexibilidad en el procesamiento de estructuras de datos complejas como, en nuestro caso, figuras.
