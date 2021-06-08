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

--Radom Svgs

--Gera uma receita de inteiro aleatório entre x e y
rndBet :: (Int,Int) -> IO Int
rndBet (x,y) = randomRIO(x,y)

--Recebe duas listas de inteiros e associa cada valor irmão das listas em uma tupla (x,y)
genPointList :: [Int] -> [Int] -> [(Int, Int)]
genPointList listX listY = zip listX listY

--Gera uma lista de Strings de tag svgPatch com curva;
genCurves :: [(Int, Int)] -> [String] -> Int -> [String]
genCurves pointList colors n = [svgCurvedPath (p !! (a*4)) (p !! ((a*4)+1)) (p !! ((a*4)+2)) (p !! ((a*4)+3)) (colors !! a)| a <- [0..n-1]] where p = pointList

--Gera um svgPath curvado
svgCurvedPath :: (Int, Int) -> (Int, Int) -> (Int, Int) -> (Int, Int) -> String -> String
svgCurvedPath (x, y) (cx, cy) (cx2, cy2) (x2, y2) color = svgPath ("M "++ show x ++ " " ++ show y ++ " C " ++ show cx ++ " " ++ show cy ++ " " ++ show cx2 ++ " " ++ show cy2 ++ " " ++ show x2 ++ " " ++ show y2) ("stroke-width: 3;stroke: rgb"++ color ++";fill: none;")

genBrokens :: [(Int, Int)] -> [String] -> Int -> [String]
genBrokens pointList colors n = [svgBrokenPath (p !! (a*4)) (p !! ((a*4)+1)) (p !! ((a*4)+2)) (p !! ((a*4)+3)) (colors !! a)| a <- [0..n-1]] where p = pointList

--Gera um path com quebras
svgBrokenPath :: (Int, Int) -> (Int, Int) -> (Int, Int) -> (Int, Int) -> String -> String
svgBrokenPath (x, y) (cx, cy) (cx2, cy2) (x2, y2) color = svgPath ("M "++ show x ++ " " ++ show y ++ " " ++ show cx ++ " " ++ show cy ++ " " ++ show cx2 ++ " " ++ show cy2 ++ " L " ++ show x2 ++ " " ++ show y2) ("stroke-width: 3;stroke: rgb"++ color ++";fill: none;")

--gera uma lista de strings no formato (r,g,b) a partir de 3 listas de string e um número n de elementos.
mergeColors :: [Int] -> [Int] -> [Int] -> Int -> [String]
mergeColors reds blues greens n = ["("++ show (reds !! x) ++ ", " ++ show (greens !! x) ++ ", " ++ show (blues !! x) ++ ")" | x <- [0..n]]

main ::  IO ()
main = do
    putStrLn "What should be the Width?"  
    w <- getLine
    putStrLn "What should be the Height?"  
    h <- getLine
    putStrLn "How much forms do you want?"  
    n <- getLine 
    putStrLn "Broken lines or curved lines? type 'b' or 'c'"  
    t <- getLine 
    putStrLn "What about colors? type 'g' for grays or 'r' for raibowMayhem"
    c <- getLine 
    --putStrLn "What should be the color? type as '(xxx,xxx,xxx)' or 'r' for color mayhem!"  
    --color <- getLine 
    --colorMayhem <- sequence [rndBet(0, 255) | x <- [0..((read n :: Int)*3)]]
    --putStrLn "Input the RGB as xxx,xxx,xxx, or... " 
    -- \n'red','blue' or 'green' if you want only randoms types of that color."  
    --colors <- getLine    

    rxList <- sequence [rndBet(1, read w :: Int) | x <- [0..((read n :: Int)*4)]] 
    ryList <- sequence [rndBet(1, read h :: Int) | x <- [0..((read n :: Int)*4)]]
    reds <- sequence [rndBet(0, 255) | x <- [0..(read n :: Int)]]
    greens <- sequence [rndBet(0, 255) | x <- [0..(read n :: Int)]]
    blues <- sequence [rndBet(0, 255) | x <- [0..(read n :: Int)]]    
    grays <- sequence [rndBet(0, 255) | x <- [0..(read n :: Int)]]    
    

    writeFile "./Abstrart.svg" (svgBegin (read w :: Int) (read h :: Int) ++ (intercalate " " (if( t == "b") then genBrokens (genPointList rxList ryList) (if(c == "r") then (mergeColors reds blues greens (read n :: Int)) else (mergeColors reds reds reds (read n :: Int))) (read n :: Int) else genCurves (genPointList rxList ryList) ((if(c == "r") then (mergeColors reds blues greens (read n :: Int)) else (mergeColors reds reds reds (read n :: Int)))) (read n :: Int))) ++ svgEnd) 
    
    
    --Implementar formas geométricas, case of e where.
      
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

-- Funções Mortas, Pobres funções que não funcionaram ou não foram implementadas T-T --


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
 --garante que sejam pegados 4 elementos do vetor de números aleatórios sem repetir elementos, ou se 

--getRandomPathValues :: Int -> [(Int, Int, Int, Int)]
--getRandomPathValues n = [(listRand !! x*4, listRand!!( x*4+1), listRand!!( x*4+2), listRand!!( x*4+3)) | x <- [0..n]] 
--                        where listRand = [1..100]

