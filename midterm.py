class Empty:
    def __init__(self):
        self.data = "Empty"

    def __str__(self):
        return "Empty"

    def tmap(self, func):
        return "Empty"

class Node:
    def __init__(self, data, left, right):
        self.data = data
        self.right = right
        self.left = left

    def __str__(self):
        return ("Node(" + str(self.data) + ", " + str(self.left) + ", " + str(self.right) + ")")

    def tmap(self, func):
        if self.data != "Empty":
            self.data = func(self.data)
            if self.left != "Empty":
                self.left.tmap(func)
            if self.right != "Empty":
                self.right.tmap(func)
    

if __name__ == '__main__':

    t = Node (1,
              Node (2, Empty(), Empty()),
              Node (3, 
                    Node (4, Empty(), Empty()),
                    Empty()))
    print(t)
    t.tmap(lambda x: x+1)
    print(t)
