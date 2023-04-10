module Dibujos.Grilla (
    grillaConf
) where

import Graphics.Gloss (Picture, blue, color, line, pictures, red, white, text, scale, translate)

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar)
import FloatingPic (Output, half, zero)
import Interp (Conf(..), interp)


-- tipo de dato para mostrar texto como picture
data BasicaTexto = Texto String
    deriving (Show, Eq)

-- funcion para interpolar el tipo de dato BasicaTexto
interpBasicaTexto :: Output BasicaTexto
interpBasicaTexto (Texto s) x y w =  translate (fst (x V.+ half w)) (snd (y V.+ half w)) $ scale 0.1 0.1 $ text s

texto :: String -> Dibujo BasicaTexto
texto = figura . Texto



row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar (fromIntegral $ length ds) 1 d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar (fromIntegral $ length ds) 1 d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

testAll :: Dibujo BasicaTexto
testAll = grilla [[texto "(0,0)", texto "(0,1)", texto "(0,2)", texto "(0,3)"],
                  [texto "(1,0)", texto "(1,1)", texto "(1,2)", texto "(1,3)"],
                  [texto "(2,0)", texto "(2,1)", texto "(2,2)", texto "(2,3)"],
                  [texto "(3,0)", texto "(3,1)", texto "(3,2)", texto "(3,3)"]]

grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla",
    pic = interp interpBasicaTexto testAll
}
