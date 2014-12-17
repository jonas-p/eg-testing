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
