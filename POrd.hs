module POrd where

import Set
import SetEq

class POrd a where
	pcompare :: a -> a -> POrdering
	lt :: a -> a -> Bool
	gt :: a -> a -> Bool
	lte :: a -> a -> Bool
	gte :: a -> a -> Bool
	inc :: a -> a -> Bool


	lt x y = (pcompare x y) == PLT
	gt x y = (pcompare x y) == PGT
	lte x y = (pcompare x y) /= PGT
	gte x y = (pcompare x y) /= PLT
	inc x y = (pcompare x y) == PIN