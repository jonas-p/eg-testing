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
-- E.g. third ("one","two","three") -> "three"
-- E.g. third (1,2,3) -> 2
third :: (a,b,c) -> c
third (_,_,x) = x

-- Returns the same string
-- E.g. same "one" -> "one"
same :: String -> String
same str = str
```
**Output from running _eg-testing example.hs_**
```
Loading file
Importing Prelude

Testing module Example
OK    plusOne (-1)
OK    plusOne 99
OK    third ("one","two","three")
FAIL  third (1,2,3) - EXPECTED "2", GOT: "3"
OK    same "one"

Done
```
