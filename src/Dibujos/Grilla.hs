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
interpBasicaTexto (Texto s) x y w =  translate (fst x) (snd x) $ scale 0.1 0.1 $ text s

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
testAll = grilla [[texto "(0,0)", texto "(0,1)", texto "(0,2)", texto "(0,3)", texto "(0,4)", texto "(0,5)", texto "(0,6)", texto "(0,7)"],
                  [texto "(1,0)", texto "(1,1)", texto "(1,2)", texto "(1,3)", texto "(1,4)", texto "(1,5)", texto "(1,6)", texto "(1,7)"],
                  [texto "(2,0)", texto "(2,1)", texto "(2,2)", texto "(2,3)", texto "(2,4)", texto "(2,5)", texto "(2,6)", texto "(2,7)"],
                  [texto "(3,0)", texto "(3,1)", texto "(3,2)", texto "(3,3)", texto "(3,4)", texto "(3,5)", texto "(3,6)", texto "(3,7)"],
                  [texto "(4,0)", texto "(4,1)", texto "(4,2)", texto "(4,3)", texto "(4,4)", texto "(4,5)", texto "(4,6)", texto "(4,7)"],
                  [texto "(5,0)", texto "(5,1)", texto "(5,2)", texto "(5,3)", texto "(5,4)", texto "(5,5)", texto "(5,6)", texto "(5,7)"],
                  [texto "(6,0)", texto "(6,1)", texto "(6,2)", texto "(6,3)", texto "(6,4)", texto "(6,5)", texto "(6,6)", texto "(6,7)"],
                  [texto "(7,0)", texto "(7,1)", texto "(7,2)", texto "(7,3)", texto "(7,4)", texto "(7,5)", texto "(7,6)", texto "(7,7)"]]


grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla",
    pic = interp interpBasicaTexto testAll
}
