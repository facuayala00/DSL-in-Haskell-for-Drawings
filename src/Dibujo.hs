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
figura = Figura

rotar :: Dibujo a -> Dibujo a --Gaston
rotar = Rotar

espejar :: Dibujo a -> Dibujo a --Facu
espejar = Espejar

rot45 :: Dibujo a -> Dibujo a --Benja
rot45 = Rot45

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a --Gaston
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a --Facu
juntar = Juntar

encimar :: Dibujo a -> Dibujo a -> Dibujo a --Benja
encimar = Encimar 


-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a  --Gaston
-- r180 a = rotar (rotar a)
r180 = rotar . rotar


r270 :: Dibujo a -> Dibujo a
-- r270 a = rotar (rotar (rotar a)) -- no tengo idea si esto es asi xd 
r270 = rotar . rotar . rotar



-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a --Benja
(.-.) x y = Apilar 1 1 x y --le pongo el 1 1 el tema de la escala pero hay que ver bien que onda

--escalas 1 1 (0.5 0.5), 2 3 (1/3 2/3)

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a --Gaston
(///) a b = juntar 1 1 a b

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a --Facu
(^^^) a b = encimar a b 

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a --Benja
cuarteto d1 d2 d3 d4 = (.-.) ((///) d1 d2) ((///) d3 d4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a --Gaston
encimar4 a = encimar(r270 encimar(r180 encimar (a (rotar a)))) --medio raro

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a --Facu
ciclar x = (.-.)((///) a (rotar a)) ((///) (r180 a) (r270 a))
{-
    r180    r270
    r0       r90
    Creo que asi esta bien el orden, pero no estoy seguro 
-}

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib f r es r45 ap ju en (Figura x) = figura x 
foldDib f r es r45 ap ju en (Rotar x)  = rotar (foldDib f r es r45 ap ju en x)
foldDib f r es r45 ap ju en (Espejar x) = espejar (foldDib f r es r45 ap ju en x)
foldDib f r es r45 ap ju en (Rot45 x) = rot45 (foldDib f r es r45 ap ju en x)
foldDib f r es r45 ap ju en (Apilar x) = apilar (foldDib f r es r45 ap ju en x)
foldDib f r es r45 ap ju en (Juntar x) = juntar (foldDib f r es r45 ap ju en x)
foldDib f r es r45 ap ju en (Encimar x) = encimar (foldDib f r es r45 ap ju en x)

{- 
    f = figura
    r = rotar 
    es = espejar
    r45 = rotar45
    ap = apilar
    ju = juntar
    en = encimar
-}

-- Demostrar que `mapDib figura = id` --Facu
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib fun x = undefined 

-- Junta todas las figuras básicas de un dibujo. --Gaston
figuras :: Dibujo a -> [a]
figuras x = undefined 
