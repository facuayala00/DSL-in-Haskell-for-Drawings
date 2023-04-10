module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid)


-- Interpretación de un dibujo
-- formulas sacadas del enunciado
interp :: Output a -> Output (Dibujo a)
interp interpFig = foldDib interpFig interpRotar interpEspejar interpRot45 interpApilar interpJuntar interpEncimar

interpRotar :: FloatingPic -> FloatingPic


interpEspejar :: FloatingPic -> FloatingPic


interpRot45 :: FloatingPic -> FloatingPic


interpApilar :: FloatingPic -> FloatingPic -> FloatingPic


interpJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpJuntar n m f g x w h = pictures[f (x, w', h), g (x+w', r'*w, h)]
    where r' = n / (n + m)
          r  = m / (n + m)
          w' = r * w

interpEncimar :: FloatingPic -> FloatingPic -> FloatingPic
interpEncimar f g x w h = pictures[f (x, w, h), g (x, w, h)]


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