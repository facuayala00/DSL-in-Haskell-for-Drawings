module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid)


type Output a = a -> Vector -> Vector -> Vector -> Picture
-- Interpretación de un dibujo
-- formulas sacadas del enunciado
interp :: Output a -> Output (Dibujo a)
interp f (Figura a)      = f a
interp f (Rotar a)       = f (x+w, h, -w) 
interp f (Rot45 a)       = f (x+(w+h)/2, (w+h)/2, (h-w)/2)
interp f (Espejar a)     = f (x+w, -w, h)
interp f (Encimar a b)   = pictures[interp f a, interp f b]
interp f (Juntar n m a b) = pictures[interp f a (x, w', h), interp f b (x+w', r'*w, h)]
interp f (Apilar n m a b) = pictures[interp f a (x+h', w, r*h), interp f b (x, w, h')]
where r' = n/(m+n),
        r = m/(m+n),
        w' = r*w,
        h' = r'*h

-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

interpConf :: Conf -> Float -> Float -> Picture 
interpConf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
        grey = makeColorI 120 120 120 120