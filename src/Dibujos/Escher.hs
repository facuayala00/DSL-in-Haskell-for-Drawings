module Dibujos.Escher (
    escherConf
) where

import Graphics.Gloss (Picture, blue, color, line, pictures, red, white, polygon, blank)

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo
import FloatingPic 
import Interp (Conf(..), interp)

data Basica = Triangulo | Blank
    deriving (Show, Eq)

type Escher = Basica

interpBas :: Output Basica
interpBas Blank a b c = blank
interpBas Triangulo a b c = pictures [line $ triangulo a b c, cara a b c]
  where
      triangulo a b c = map (a V.+) [zero, c, b, zero]
      cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

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
esquina 0 _ = (figura Blank)
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (rotar (lado (n-1) p)) (dibujoU p)


-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = (figura Blank)
lado n p = cuarteto (lado (n-1) p ) (lado (n-1) p) (rotar (dibujoT p)) (dibujoT p) 

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = apilar 2 1 (juntar 2 1 p (juntar 1 1 q r)) 
                           (apilar 1 1 (juntar 2 1 s (juntar 1 1 t u)) 
                           (juntar 2 1 v (juntar 1 1 w x)))

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n p = noneto (esquina n (figura p)) (lado n (figura p)) (r270 (esquina n (figura p)))
                    (rotar (lado n (figura p))) (dibujoU (figura p)) (r270 (lado n (figura p)))
                    (rotar (esquina n (figura p))) (r180 (lado n (figura p))) (r180 (esquina n (figura p)))

escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = interp interpBas (escher 5 Triangulo)
}
