module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP
) where

import Dibujo

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred TriOCuat` que devuelve `True` cuando la
-- figura es `Triangulo`.

type Pred a = a -> Bool


-- Dado un predicado sobre figuras básicas, cambiar todas las que satisfacen
-- el predicado por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Figura x))` rota
-- todos los triángulos.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar pred fun x = mapDib (\x -> if pred x then fun x else figura x) x


-- Alguna figura satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred x = foldDib pred id id id (\ _ _ x y -> x || y) (\ _ _ x y -> x || y) (\x y -> x || y) x

-- Todas las figuras satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib pred x = foldDib pred id id id (\ _ _ a b -> a && b) (\ _ _ a b -> a && b) (\x y -> x && y) x

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP pred1 pred2 e = pred1 e && pred2 e

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP pred1 pred2 e = pred1 e || pred2 e
