module E3 where

-- interleave xs ys 
-- return a list of corresponding elements from xs and ys, 
-- interleaved. The remaining elements of the longer list
-- are ignored.
-- interleave [1, 2] [3, 4] --> [1, 3, 2, 4]
-- Example: 
interleave [] [] = []
interleave (x:xs) (y:ys) = x : y : (interleave xs ys)

-- repeat n f x
-- return a list [x, f(x), f(f(x)), ..., f^n(x)]
-- reuires n >= 0
repeat1 0 f x = []
repeat1 n f x = x : repeat1 (n-1) f (f x)

-- A funny tree.
data Tree a = Leaf a | Node  (a, Tree a, Tree a)

-- countNodes t
-- return the number of nodes in tree t
countNodes (Leaf a) = 1
countNodes  (Node(_,rest1,rest2)) = 1 + countNodes rest1 + countNodes rest2

-- forallNodes p t
-- return whether p is true of every node in tree t
forallNodes p (Leaf a) = if (p a) then True else False
forallNodes p (Node(a,left,right))=  if (p a) then forallNodes p left == forallNodes p right else False

-- existsNode p t
-- return whether p is true of some node in tree t
existsNode p (Leaf a) = if (p a) then True else False
existsNode p (Node(a,left,right)) = if (p a) then True else existsNode p left || existsNode p right

-- inorder t
-- return a list of nodes in t in inorder traversal order
inorder (Leaf a) = [a]
inorder (Node (a,l,r)) =  inorder l ++ [a] ++ inorder r

-- a linear-time tail-recursive version
inorderLiner (Node (a,l,r)) = inorderL (Node (a,l,r)) []
		where
			inorderL (Leaf a) c = [a]
			inorderL (Node (a,l,r)) c = inorderL l ([a] ++ c) ++ [a] ++ inorderL r (c ++ [a])

tfold f g (Leaf x) = f x
tfold f g (Node (x, left, right)) = 
    g x (tfold f g left) (tfold f g right)
tfold:: (a -> b) -> (a -> b -> b -> b) -> Tree a -> b

countNodes' (Node (x, left, right)) = tfold f1 g1 (Node (x, left, right))
  		where {f1 x = 1;
  		 	  g1 x y z = 1 + y + z}

forallNodes' p (Node (x , left, right)) = tfold f2 g2 (Node (x, left, right))
		where {f2 p x = if (p x) then True else False;
			   g2 p x y z = if (p x) then y == z else False}
existsNode' = 42
inorder' = 42