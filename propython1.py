class variable:
    def __init__(self, x):
        self.x = x

    def getxv(self):
        return self.x
        
    def __str__(self):
        return "variable(" + self.x.__str__() + ")"

class neg:
    def __init__(self, x):
        self.x = x

    def getxn(self):
        return self.x
        
    def __str__(self):
        return "neg(" + self.x.__str__() + ")"

class And:
    def __init__(self, l):
        self.l = l
        

    def getl(self):
        return self.l
        
    def __str__(self):
        s = ""
        for i in self.l[:-1]:
            s += i.__str__() + " ,"
        return "And(" + s + self.l[-1].__str__() + ")"

class Or:
    def __init__(self, l):
        self.l = l
        

    def getl(self):
        return self.l
        
    def __str__(self):
        s = ""
        for i in self.l[:-1]:
            s += i.__str__() + " ,"
        return "Or(" + s + self.l[-1].__str__() + ")"

class implies:

    def __init__(self, x0, x1):
        self.x0 = x0
        self.x1 = x1

    def getfirst(self):
        return self.x0

    def getsecond(self):
        return self.x1

    def __str__(self):
        return "implies(" + self.getfirst().__str__() + "," + self.getsecond().__str__() +")"

def formula(f):

    if f.__class__.__name__ == 'variable':
        if isinstance(f.__class__.getxv(f), str):
            if f.__class__.getxv(f).isalpha():
                return True
            else:
                return False
        else:
            return False
    elif f.__class__.__name__ == 'neg':
        return formula(f.__class__.getxn(f))
    elif f.__class__.__name__ == 'And':
        l = f.__class__.getl(f)
        for i in l:
            formula(i)
        return True
    elif f.__class__.__name__ == 'Or':
        l = f.__class__.getl(f)
        for i in l:
            formula(i)
        return True
    elif f.__class__.__name__ == 'implies':
        x0 = f.__class__.getfirst(f)
        x1 = f.__class__.getsecond(f)
        if formula(x0) and formula(x1):
            return True
        else:
            return False
    else:
        return False

def sub(f, Asst, output):
    if f == 'tru':
        output = 'tru'
        return output
    elif f == 'fls':
        output = 'fls'
        return output
    elif f.__class__.__name__ == 'variable':
        if f.__class__.getxv(f) in Asst:
            output = variable(Asst[f.__class__.getxv(f)])
            return output.getxv()
        else:
            return False
    elif f.__class__.__name__ == 'neg':
        if (sub(f.__class__.getxn(f), Asst, output)) == 'tru':
            n = neg('tru')
            return n.__str__()
        else:
            n = neg('fls')
            return n.__str__()
    elif f.__class__.__name__ == 'And':
        l = f.__class__.getl(f)
        newl = []
        for i in l:
            if sub(i, Asst, output) != False:
                n = sub(i, Asst, output)
                newl.append(n)
            else:
                return False
        return "And" + newl.__str__()
    elif f.__class__.__name__ == 'Or':
        l = f.__class__.getl(f)
        newl = []
        for i in l:
            if sub(i, Asst, output) != False:
                n = sub(i, Asst, output)
                newl.append(n)
            else:
                return False
        return "Or" + newl.__str__()
    elif f.__class__.__name__ == 'implies':
        x0 = f.__class__.getfirst(f)
        x1 = f.__class__.getsecond(f)
        if (sub(x0, Asst, output) != False) and (sub(x1, Asst, output) != False):
            n0 = sub(x0, Asst, output)
            n1 = sub(x1, Asst, output)
            return "implies(" + n0.__str__() + ' ,' + n1.__str__() + ")"
    else:
        return False
            
def Eval(f, Asst, output):
    if f == 'tru':
        output = 'tru'
        return output
    elif f == 'fls':
        output = 'fls'
        return output
    elif f.__class__.__name__ == 'variable':
        if f.__class__.getxv(f) in Asst:
            output = variable(Asst[f.__class__.getxv(f)])
            return output.getxv()
        else:
            return False
    elif f.__class__.__name__ == 'neg':
        if (Eval(f.__class__.getxn(f), Asst, output)) == 'tru':
            return 'fls'
        else:
            return 'tru'
    elif f.__class__.__name__ == 'And':
        l = f.__class__.getl(f)
        newl = []
        for i in l:
            if Eval(i, Asst, output) != False:
                n = Eval(i, Asst, output)
                newl.append(n)
            else:
                return False
        for j in newl:
            if j == 'fls':
                return 'fls'
        return 'tru'
    elif f.__class__.__name__ == 'Or':
        l = f.__class__.getl(f)
        newl = []
        for i in l:
            if Eval(i, Asst, output) != False:
                n = Eval(i, Asst, output)
                newl.append(n)
            else:
                return False
        for j in newl:
            if j == 'tru':
                return 'tru'
        return 'fls'
    elif f.__class__.__name__ == 'implies':
        x0 = f.__class__.getfirst(f)
        x1 = f.__class__.getsecond(f)
        if (Eval(x0, Asst, output) != False) and (Eval(x1, Asst, output) != False):
            n0 = Eval(x0, Asst, output)
            n1 = Eval(x1, Asst, output)
            if (n0 == 'fls') and (n1 == 'tru'):
                return 'fls'
            else:
                return 'tru'
        else:
           return False
    else:
        return False
if __name__ ==  "__main__":
	var=variable('x')
	ne=neg(var)
	an=And([variable('b'),neg('fls')])
	o=Or([variable('a')])
	imp=implies(variable('a'),an)
	
	print("pre-define:")
	print(var)
	print(ne)
	
	print(an)
	print(o)
	print(imp)
	
	print("-----Formula example-----")
	print("Formula(x)")
	print(">>>"+str(formula('x')))
	print("Formula("+str(var)+")")
	print(">>>"+str(formula(var)))
	print("Formula("+str(imp)+")")
	print(">>>"+str(formula(imp)))
	
	print("-----Sub example-----")
	print("sub("+str(ne)+","+str("{'x':'tru','y':'fls'}")+ ",[])")
	print(">>>"+str(sub(ne,{'x':'tru', 'y':'fls'},[])))
	
	print("Sub("+str(an)+","+str("{'b':'tru','y':'fls'}")+ ",[])")
	print(">>>"+str(sub(an,{'b':'tru', 'y':'fls'},[])))
	
	print("Sub("+str(o)+","+str("{'a':'tru','b':'fls'}") + ",[])")
	print(">>>"+str(sub(o,{'a':'tru','b':'fls'},[])))
	
	print("Sub("+str(imp)+","+str("{'a':'tru','b':'fls'}")+",[]")
	print(">>>"+str(sub(imp,{'a':'tru','b':'fls'},[])))
	
	print("-----Eval example-----")
	print("Eval("+str(ne)+","+str("{'x':'tru','y':'fls'}")+ ",[])")
	print(">>>"+str(Eval(ne,{'x':'tru', 'y':'fls'},[])))
	
	print("Eval("+str(an)+","+str(["x/tru","y/fls"])+",None)")
	print(">>>"+str(Eval(an,{'x':'tru','y':'fls'},None)))
	
	print("Eval("+str(o)+","+str("{'a':'tru','b':'fls'}")+ ",[]")
	print(">>>"+str(Eval(o,{'a':'tru','b':'fls'},{})))
	
	print("Eval("+str(imp)+","+str("{'a':'fls','b':'tru'}")+",None)")
	print(">>>"+str(Eval(imp,{'a':'fls','b':'tru'},None)))
        
