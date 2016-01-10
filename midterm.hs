module Lab7 where

data Tree a = Empty | Node (a, Tree a, Tree a)

t = Node (1,
           Node (2, Empty, Empty),
           Node (3, 
                 Node (4, Empty, Empty),
                 Empty))
tInc = Node (2,
           Node (3, Empty, Empty),
           Node (4, 
                 Node (5, Empty, Empty),
                 Empty))
tFlip = Node (1,
            Node (3, 
                  Empty,
                  Node (4, Empty, Empty)),
            Node (2, Empty, Empty))

-- numNodes t
-- Return the number of nodes in the tree t.
-- For example, 
--   numNodes t    should return    4
numNodes Empty = 0
numNodes (Node(a, l, r)) = 1 + numNodes l + numNodes r

-- numLevels t
-- Return the number of levels in the tree t (i.e., return
-- the number of nodes on the longest root-to-leaf path in
-- the tree t).
-- For example, 
--   numLevels t    should return    3
numLevels Empty = 0
numLevels (Node(a, l, r)) = if numLevels l > numLevels r then 1 + numLevels l else 1 + numLevels r

-- flip t
-- Return a tree which is a result of swapping, for every non-leaf
-- node in the tree, its right and left child.
-- For example, 
--   flip t    should return a tree like this:
--        Node (1,
--            Node (3, 
--                  Empty,
--                  Node (4, Empty, Empty)),
--            Node (2, Empty, Empty))
tflip Empty = Empty
tflip' (Node(a, l, r)) = (Node(a, tflip r, tflip l))

-- map f t
-- Return a tree which results from applying the function f to
-- every node in the tree t.
-- For example,
--   map (+1) t   should return a tree like this:
--   Node (2,
--         Node (3, Empty, Empty),
--         Node (4, 
--               Node (5, Empty, Empty),
--               Empty))
tmap f Empty = Empty
tmap f (Node(a, l, r)) = (Node((f a), (tmap f l), (tmap f r)))

-- sumAbs xs
-- Return the sum of absolute values of xs.
-- For example, 
--  sumAbs [1,-2,-3]    should return    6
sumAbs = foldr f 0 where
    f x y = (abs x) + (abs y) 

-- bound low high xs
-- Return a list of elements from xs, with every element that is
-- less than low replaced with low and every element that is
-- bigger than high replaced with high.
-- For example, 
--  bound 0 10 [-2,3,4,14,6]    should return    [0,3,4,10,6]
bound low high = map (\x -> if x <= low then low else if x >= high then high else x)

prime x = null [y | y <- [2..(x - 1)], x `mod` y == 0]