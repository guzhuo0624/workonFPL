module E4 where

-- |numNeg xs return a number of negative elements in xs.
-- Use list comprehension!
numNeg xs = sum [1 | x <- xs, x < 0] 

-- |genSquares low high return a list of squares of even integers
-- between low and high. Use list comprehension!
genSquares low high = [x^2 | x <- [low..high], even x]

-- |triples n return a list of triples (x,y,z) all less than n, such
-- that x^2 + y^2 == z^2, with no duplicate triples or premutations of
-- ealier tripales.
-- Use list comprehension!
triples n = [(x,y,z) | x <- [1..n], y <- [x..n], z <- [x..n], x * x + y * y == z * z]

-- |triples' an ifinite list of triples as above. Use list comprehension!
triples' = [(x,y,z) | z <- [1..], x <- [1..z], y <- [x..z], x * x + y * y == z * z]

-- |cycle' n return an infinitly repeating list of numbers from 0 to n 
cycle' n = loop 0 n where
	loop x y = x `mod` n : loop (x+1) n
