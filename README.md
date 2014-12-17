eg-testing
==========

Tests Haskell code by using E.g. comments in the source files

## Dependencies
- Language.Haskell.Interpreter (hint)
- System.Console.ANSI (ansi-terminal)
- Text.Regex.Posix (regex-posix)

**Installation using cabal:**
```
cabal install hint
cabal install ansi-terminal
cabal install regex-posix
```

### Example
```
# compiling
ghc main.hs -o eg-testing

# running
eg-testing example.hs
```
**example.hs**
```
module Example where

-- Adds 1 to the provided integer
-- E.g. plusOne (-1) -> 0
-- E.g. plusOne 99 -> 100
plusOne :: Int -> Int
plusOne a = a + 1

-- Returns the third element of a triplet
-- E.g. third (1,2,3) -> 3
third :: (a,b,c) -> c
third (_,_,x) = x

-- This function should return the product
-- of two integers (it doesn't).
-- E.g. prod 1 1 -> 1
-- E.g. prod 5 4 -> 20
prod :: Integer -> Integer -> Integer
prod a b = a + b
```
**Output from running _eg-testing example.hs_**
```
Loading file
Importing Prelude

Testing module Example
OK    plusOne (-1)
OK    plusOne 99
OK    third (1,2,3)
FAIL  prod 1 1 - EXPECTED "1", GOT: "2"
FAIL  prod 5 4 - EXPECTED "20", GOT: "9"

Done
```
