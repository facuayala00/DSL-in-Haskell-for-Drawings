{-# LANGUAGE LambdaCase #-}
module Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
) where


{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig> 
    | Juntar <Float> <Float> <Fig> <Fig> 
    | Encimar <Fig> <Fig>
-}


data Dibujo a = Figura a
    | Rotar (Dibujo a) 
    | Espejar (Dibujo a) 
    | Rot45 (Dibujo a)
    | Apilar (Float) (Float) (Dibujo a) (Dibujo a) 
    | Juntar (Float) (Float) (Dibujo a) (Dibujo a) 
    | Encimar (Dibujo a) (Dibujo a)
    deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Construcción de dibujo. Abstraen los constructores.
figura :: Dibujo a -> Figura a --Benja
figura x = Figura x 

rotar = undefined --Gaston

espejar :: Dibujo a -> Dibujo a --Facu
espejar x = Espejar x

rot45 :: Dibujo a -> Dibujo a --Benja
rot45 = undefined --No se que hacer aca.

apilar = undefined --Gaston

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a --Facu
juntar x y z w = Juntar x y z w

encimar :: Dibujo a -> Dibujo a -> Dibujo a --Benja
encimar x y = Encimar x y 


-- Rotaciones de múltiplos de 90.
r180 = undefined --Gaston


r270 :: Dibujo a -> Dibujo a
r270 a = Rotar (Rotar (Rotar a)) -- no tengo idea si esto es asi xd 


-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) = undefined --Benja

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) = undefined --Gaston

-- Superpone una figura con otra.
(^^^) = undefined --Facu

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto = undefined --Benja

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 = undefined --Gaston

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar = undefined --Facu

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib = undefined --Benja

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib = undefined --Facu

-- Junta todas las figuras básicas de un dibujo.
figuras = undefined --Gaston
