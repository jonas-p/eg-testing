module Main where

import Control.Monad
import System.Environment
import System.Exit

-- cabal install hint
import Language.Haskell.Interpreter
-- cabal install ansi-terminal
import System.Console.ANSI
-- cabal install regex-posix
import Text.Regex.Posix

main :: IO()
main =
   do
      -- Argument checking
      args <- getArgs
      if length args == 0 then do
         putStrLn "Specify input file."
         exitFailure
      else
         return ()

      -- Load file from first provided argument
      file <- readFile (args !! 0)
      
      -- Retrieve all tests from file using regex
      -- the resulting list is in format [[_, _, EXPR, RES]]
      -- where EXPR is the expression we want to test, and RES
      -- is the expected result.
      let raw = file =~ "^-- E\\.g\\. ((.+) -> (.+))$" :: [[String]]
      if length raw == 0 then do
         putStrLn "Couldn't find any tests in the provided file."
         exitFailure
      else
         return ()

	  -- Create a list of tuples with the 3rd and 4th element of
	  -- every list in raw
      let tests = map (\x -> (x !! 2, x !! 3)) raw

      -- Run tests
      r <- runInterpreter $ egChecking (args !! 0) tests 
      case r of
         Left err -> putStrLn $ show err
         Right () -> putStrLn "Done"

-- Runs eval on every item in the list and compares
-- and prints the result.
evalList :: [(String, String)] -> Interpreter ()
evalList [] = return ()
evalList (x:xs) =
   do
      res <- eval (fst x)
      let b = test res (snd x)
      sayResult b 
      say ("\t" ++ (fst x))
      when (b == False) $ say (" - EXPECTED " ++ show (snd x) ++ ", GOT: " ++ show res)
      say "\n"
      evalList xs

-- Loads the module from the provided string imports prelude and
-- runs all provided tests
egChecking :: String -> [(String, String)] -> Interpreter ()
egChecking file tests =
   do
      say "Loading file\n"
      loadModules [file]
      modules <- getLoadedModules
      setTopLevelModules modules
      --
      say "Importing Prelude\n"
      setImportsQ[("Prelude", Nothing)]
      --
      say "\n"
      say ("Testing module " ++ modules !! 0 ++ "\n")
      evalList tests
      say "\n"

-- Returns OK if the two strings are equal
-- and FAIL otherwise
test :: String -> String -> Bool
test s1 s2 = if s1 == s2 then True else False

-- Prints output
say :: String -> Interpreter ()
say = liftIO . putStr

-- Prints OK in green text if the provided
-- bool is True, otherwise FAIL in red text
-- is printed
sayResult :: Bool -> Interpreter ()
sayResult res = do
   if res == True then do
      liftIO $ setSGR [SetColor Foreground Vivid Green]
      liftIO $ putStr "OK"
   else do
      liftIO $ setSGR [SetColor Foreground Vivid Red]
      liftIO $ putStr "FAIL"
   liftIO $ setSGR []
