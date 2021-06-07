module Main where
import System.Random
import Text.Printf
import Data.List

--abstrart :: (Int,Int) -> (Int,Int)
--abstrart (x,y) = (randomRIO(1,x) :: IO Int, randomRIO(1,y):: IO Int)

-- rndbet é a minha função randomBetween, ela retorna um IO Int, que por algum motivo é diferente do Int.
-- IO Int é diferente do Int por que o haskell não pode permitir que uma função returne um valor diferente utilizando 
-- os mesmos parametros, por sua natureza funcional, coisa que um chamada de IO poderia fazer, quebrando o sentido de uma função matemática.

-- funções svg
-- inicia a tag html do svg, determinando a altura e largura.
svgBegin :: Int -> Int -> String
svgBegin w h = printf "<svg width='%i' height='%i' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- função que printa o fechamento da tag svg
svgEnd :: String
svgEnd = "</svg>"

svgPath :: String -> String -> String 
svgPath d style = 
  printf "<path d='%s' style='%s' />\n" d style

--randomCircle

rndBet :: (Int,Int) -> IO Int
rndBet (x,y) = randomRIO(x,y)

--defineColor :: String -> String
--defineColor color
--    |color == "red" = "("++rndBet(1, 255)++", 0, 0)"
--    |color == "blue" = "(0,"++rndBet(1, 255)++", 0)"
--    |color == "green" = "(0, 0, "++rndBet(1, 255)++")"
--    |otherwise = color

--listRndBet :: (Int,Int) -> Int -> [IO Int]
--listRndBet (x,y) n = [randomRIO(x,y) | a <- [1..n]]

--svgGen :: [(Int, Int, Int, Int)] -> String
--svgGen listPoints = intercalate "" ["sadas", "adasda", "asdas"]


--svgGen :: Int -> Int -> Int -> String
--svgGen w h n =  intercalate " " (map show ([randomRIO(1,w) | x <- [1..n]])) -- ([(randomRIO(1,w), randomRIO(1,h)) | x <- [1..n]])
--svgGenPath (w, h) n = (map (\ (a,b) -> show a ++ show b) ([(randomRIO(1,w), randomRIO(1,h)) | x <- [1..n]]))  
--svgGen :: (Int, Int, Int, Int) -> String
--svgGen 
--
--svgPathRnd :: (Int, Int, Int, Int) -> String
--svgPathRnd (x,y,a,b) n = svgPath ("M "++ show x ++ " " ++ show y ++ " L "++ show a ++ " " ++ show b) "stroke-width: 3;stroke:red;fill: none;"
--[ ((randomRIO(1,(read w :: Int)), randomRIO(1,(read h :: Int))), (randomRIO(1,(read w :: Int)), randomRIO(1,(read h :: Int)))) | a <- [1..(read n :: Int)]]
 --listRndBet :: (Int,Int) -> Int -> [IO Int]
--listRndBet (x,y) n = [randomRIO(x,y) | a <- [1..n]]

main :: IO ()
main = do
    putStrLn "What should be the Width?"  
    w <- getLine
    putStrLn "What should be the Height?"  
    h <- getLine
    putStrLn "Input the RGB as xxx,xxx,xxx, or... " 
    -- \n'red','blue' or 'green' if you want only randoms types of that color."  
    colors <- getLine    
    x <- rndBet(1, read w :: Int)
    y <- rndBet(1, read h :: Int)  
    x2 <- rndBet(1, read w :: Int)
    y2 <- rndBet(1, read h :: Int)  
    cx <- rndBet(1, read w :: Int)
    cy <- rndBet(1, read h :: Int) 
    cx2 <- rndBet(1, read w :: Int)
    cy2 <- rndBet(1, read h :: Int)    
    
    writeFile "./Abstrart.svg" (svgBegin (read w :: Int) (read h :: Int) ++ svgPath ("M "++ show x ++ " " ++ show y ++ " " ++ show cx ++ " " ++ show cx2 ++ " " ++ show cy ++ " " ++ show cy2 ++ " L "++ show x2 ++ " " ++ show y2) ("stroke-width: 3;stroke: rgb(" ++ colors ++ ");fill: none;") ++ svgEnd)
    --writeFile "./Abstrart.svg" (svgBegin (read w :: Int) (read h :: Int) ++ (svgPath ("M "++ show (getrnd (read w :: Int)) ++ " 100 L 150 200") "stroke-width: 3;stroke:red;fill: none;") ++ svgEnd)
--getrnd x = do
    --r <- randomRIO(1, x)
    --return r
    --writeFile "./Abstrart.txt" show (listRndBet (1, read w :: Int ) (read n :: Int))
    --writeFile "./Abstrart.svg" (svgBegin (read w :: Int) (read h :: Int) ++ (randomSvgs rx) ++ svgEnd)
--svgMount :: Int -> Int -> String
--svgMount x y = do
--    rx <- rndBet(1, x)
--    ry <- rndBet(1, y)    
--    rx2 <- rndBet(1, x)
--    ry2 <- rndBet(1, y)
--    return svgPath ("M "++ show rx ++ " " ++ show ry ++ " L "++ show rx2 ++ " " ++ show ry2) "stroke-width: 3;stroke:red;fill: none;"