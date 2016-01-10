module Lab8 where

-- write a function that given a common ratio r and a scalar factor a,
-- returns an (infinite) geometric sequence
-- (look up geometic sequences on wikipedia, if you don't remember 
-- how they are defined)
geom a r = a : geom (a * r) r

-- can you use this function to compute the sum of an infinite
-- geometric sequence?

-- recall our datatype for binary trees
data BTree a = Empty | Node a (BTree a) (BTree a)

t = Node 10 (Node 5 (Node 2 Empty Empty)
                    (Node 7 (Node 6 Empty Empty) Empty))
            (Node 15 Empty (Node 20 Empty Empty))


-- We want to be able to compare BTrees for equality. We say that two
-- BTrees are equal if they contain the same elements. The shapes of
-- the trees do not determine whether the trees are equal.

t' = Node 7 (Node 5 (Node 2 Empty Empty)
                    (Node 6 Empty Empty))
            (Node 15 (Node 10 Empty Empty) 
                     (Node 20 Empty Empty))

t'' = Empty

tl Empty = []
tl (Node a left right) = tl left ++ [a] ++ tl right

contain a [] = False
contain a (x:xs) = a == x || contain a xs
tcompare [] [] = True
tcompare [] ys = True
tcompare xs [] = False
tcompare (x:xs) ys = contain x ys && tcompare xs ys


instance Eq a => Eq (BTree a) where
  t == t' = ((tcompare (tl t) (tl t')) && (tcompare (tl t') (tl t))) 

-- we now want to be able to display BTrees as follows (tilt your head to
-- the left!)
{-
    20
  15
10
    7
      6
  5
    2
-}

instance Show a => Show (BTree a) where
  show Empty = ""
  show (Node a l r) = "{-" ++ "\n" ++ tshow "" (Node a l r) ++ "-}" where
    tshow s Empty = ""
    tshow s (Node a l r) = (tshow (s ++ "  ") r) ++ s ++ show a ++ "\n" ++ (tshow (s ++ "  ") l)

--show 
-- Let's create a type class Sized, which prescribes a function 
-- size :: a -> Int, and provides definitions for 
-- empty :: a -> Bool and nonempty :: a -> Bool

class Sized a where
  size :: a -> Int
  empty :: a -> Bool

-- now let's state that all Bool's are of size 1, by defining a
-- corresponding instance
instance Sized Bool where
  size x = 1
  empty x = False

-- now let's make lists Sized, by defining the size of a list to be
-- its length
instance Sized [a] where
  size x = length x
  empty [] = True

-- finally, let's make our BTree's Sized, by defining the size of a
-- BTree to be the number of the elements stored in it
instance Sized (BTree a) where
  size Empty = 0
  size (Node a l r) = 1 + size l + size r
  empty Empty = True
  empty (Node a l r) = False