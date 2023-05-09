### General
Muy bien

Aclaración: en un lenguaje como Haskell, algunas cosas "cosméticas" que serían competencia de la calidad de código en otra situación, son contempladas como competencia de la funcionalidad

### Repo e informe
- Usen `.gitignore`, queda todo más limpio
- A las preguntas les falta un poco de profundidad; la variable de tipo permite abstraerse y pensar en todo tipo de figuras y además permite que las constructoras y combinadoras funcionen sin importar el tipo de dato `a` y sin modificar el tipo de dato. Utilizar fold además permite ocultar la implementación del tipo de dato y sus constructores.

### Funcionalidad
- Las funciones definidas como infijas se pueden usar como infijas
- Podrían usar `case` junto con `let in` en `foldDib`. Cuando ustedes ven código repetido de esa manera ya deberían hacerse esta pregunta, ¿No tendrá Haskell una herramienta para evitar esta repetición? y lo más probable es que exixta una forma más limpia de escribir, porque Haskell esta diseñado para eso.
- `mapDib` y `figuras` se pueden escribir usando `foldDib` y queda más limpio
- En `Grilla` lo correcto sería usar un tipo básico `(Int, Int)` para poder usar arreglos de enteros, mucho menos hardcodeados.s 
- En la grilla pueden escribir el arreglo de arreglos usando "list comprehensions"
- El Escher está muy bien hecho, bien "a lo funcional" capaz usar un where en la función `escher` para mejorar la legibilidad?
- El problema con los tests es que utilizan los constructores cuando `Dibujo` no los exporta (ni debería hacerlo)

### Calidad de código
- Hay algunas reducciones para hacer, las marca el Linter, por ejemplo reducciones eta en `Dibujo.hs` o en `Pred.hs`
- Hay código comentado
- Algunas líneas un poquito largas
- `Feo` y `Grilla` repiten código

### Modularización y diseño
- OK
