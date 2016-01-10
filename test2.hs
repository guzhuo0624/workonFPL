module test2 where
prime x = null [y | y <- [2..(x - 1)], x ‘mod‘ y == 0]