class Node:
    """
    Tree node: left and right child + data which can be any object
    """

    def __init__(self, data):
        """
        Node constructor
        """
        self.left = None
        self.right = None
        self.data = data

    def insert(self, data):
        """
        Insert new node with data
        """
        if self.data:
            if self.data > data:
                if self.left is None:
                    self.left = Node(data)
                else:
                    self.left.insert(data)
            elif self.data < data:
                if self.right is None:
                    self.right = Node(data)
                else:
                    self.right.insert(data)
        else:
            self.data = data

    
    def countNodes(self):
        if self.data is None:
            return -1
        else:
            if (self.left is None) and (self.right is None):
                return 1 
            elif (self.left is None) and (self.right is not None):
                return (1 + self.right.countNodes())
            elif (self.left is not None) and (self.right is None):
                return (1 + self.left.countNodes())
            else:
                return (1 + self.right.countNodes() + self.left.countNodes())

    def existNode(self, func):
        if func(self.data) == True:
            return True
        else:
            if (self.left is None) and (self.right is None):
                return False
            elif (self.left is None) and (self.right is not None):
                return self.right.existNode(func)
            elif (self.left is not None) and (self.right is None):
                return self.left.existNode(func)
            else:
                return (self.right.existNode(func) or self.left.existNode(func))

    def forallNode(self, func):
        if func(self.data) == True:
            if (self.left is None) and (self.right is None):
                return True
            elif (self.left is None) and (self.right is not None):
                return self.right.forallNode(func)
            elif (self.left is not None) and (self.right is None):
                return self.left.forallNode(func)
            else:
                return (self.right.forallNode(func) or self.left.forallNode(func))
        else:
            return False

    def inorder(self, stack = []):
        """
        Print tree content inorder
        """
        if self.left:
            self.left.inorder(stack)
        stack.append(self.data)
        if self.right:
            self.right.inorder(stack)
        return stack

def tfold(root, f, g):
    if ((root.left == None) and (root.right == None))
        return f(root.data)
    elif (self.left is None) and (self.right is not None):
        return g(root.data, tfold(root.right, f, g))
    elif (self.left is not None) and (self.right is None):
        return g(root.data, tfold(root.left, f, g))
    else:
        return g(root.data, tfold(root.left, f, g), tfold(root.right, f, g))

def countNode1(root):
    def func1(x):
        return 1;
    def gunc1(x, y, z):
        return 1 + y + z

if __name__ == "__main__":
    root = Node(8)
    root.insert(3,left)
    root.insert(10,right)
    root.insert(1,left)

