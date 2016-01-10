module SetPOrd where

import Set
import POrd
import SetEq

contain a [] = False
contain a (x:xs) = a == x || contain a xs



-- include only test if a list is included
include [] [] = True
include [] ys = True
include xs [] = False
include (x:xs) (ys) = contain x ys && include xs ys

instance Eq a => POrd (Set a) where

	pcompare (Set s) (Set t) =
		let 
			sIsBigger = (length s) > (length t)
			sIsEqual  = (length s) == (length t)
			sIsIncluded = include s t
			tIsIncluded = include t s
		in
			if (sIsIncluded && not sIsEqual) then PLT
			else if (sIsBigger && tIsIncluded) then PGT
			else if (sIsEqual && sIsIncluded && tIsIncluded) then PEQ
			else PIN
