module Dibujos.Escher (
    escherConf
) where

import Graphics.Gloss (Picture, blue, color, line, pictures, red, white, polygon)

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo
import FloatingPic 
import Interp (Conf(..), interp)

-- Supongamos que eligen.
type Escher = Bool

-- El dibujoU.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar4 p2
    where
        p2 = espejar (rot45 p)   

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar (p) (encimar p2 p3)
    where
        p2 = espejar (rot45 p)
        p3 = r270 p2

-- Esquina con nivel de detalle n en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 _ = blank
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (rotar (lado (n-1) p)) dibujoU p


-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = blank
lado n p = cuarteto (lado (n-1) p ) (lado (n-1) p) (rotar (dibujoT p)) dibujoT p 

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher = undefined

