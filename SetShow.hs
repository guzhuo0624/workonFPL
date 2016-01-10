module SetShow where

import Set

instance Show a => Show (Set a) where
	show (Set (x:xs)) = "{" ++ sshow x xs ++ "}" where
		sshow a [] = show a
		sshow a (y:ys) = show a ++ "," ++ (sshow y ys)