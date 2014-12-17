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
