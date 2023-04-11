module Main (main) where

import Data.Maybe (fromMaybe)
import System.Console.GetOpt (ArgDescr(..), ArgOrder(..), OptDescr(..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)

import Interp (Conf(name), initial)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Feo (feoConf)
import Dibujos.Grilla (grillaConf)
import Dibujos.Escher (escherConf)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf, grillaConf, escherConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
    putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n = 
    if n == name c then
        initial c 400
    else
        initial' cs n


-- Función que imprime los nombres de los dibujos
listarDibujos :: IO ()
listarDibujos = do
    putStrLn "Dibujos registrados:"
    mapM_ (putStrLn . name) configs


-- Muestra los posibles dibujos y le pide uno al usuario
pedirDibujo :: IO ()
pedirDibujo = do
    listarDibujos
    putStrLn "Ingrese el nombre del dibujo que desea dibujar:"
    n <- getLine
    initial' configs n

-- Procesa los argumentos que se le pasa al main
processArgs :: [String] -> IO ()
processArgs args 
    | null args = putStrLn "No se pasó ningún argumento."
    | head args == "--lista" = pedirDibujo
    | otherwise = initial' configs (head args)

main :: IO ()
main = do
    args <- getArgs
    processArgs args