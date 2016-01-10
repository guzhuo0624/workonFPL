module SetEq where

import Set


instance Eq a => Eq (Set a) where
	 (Set s) == (Set s') = ((length s == length s') && (ccompare s s')) 

ccompare [] [] = True
ccompare [] ys = False
ccompare xs [] = False
ccompare (x:xs) (ys) = ccompare xs (eliminate x ys)

eliminate :: Eq a => a -> [a] -> [a]
eliminate x [] = []
eliminate x (y:ys) = if (x == y) then ys else (y:(eliminate x ys))

