import itertools


class Formula:
    def oblicz(self, vars):
        pass


class Conj(Formula):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, vars):
        return self.left.oblicz(vars) and self.right.oblicz(vars)

    def __str__(self):
        return "(" + self.left.__str__() + " /\ " + self.right.__str__() + ")"


class Disj(Formula):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, vars):
        return self.left.oblicz(vars) or self.right.oblicz(vars)

    def __str__(self):
        return "(" + self.left.__str__() + " V " + self.right.__str__() + ")"


class Impl(Formula):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, vars):
        if self.left.oblicz(vars) is True and self.right.oblicz(vars) is False:
            return False
        else:
            return True

    def __str__(self):
        return "(" + self.left.__str__() + " => " + self.right.__str__() + ")"


class Iff(Formula):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, vars):
        return self.left.oblicz(vars) is self.right.oblicz(vars)

    def __str__(self):
        return "(" + self.left.__str__() + " <=> " + self.right.__str__() + ")"


class Zmienna(Formula):
    def __init__(self, x):
        self.x = x

    def oblicz(self, vars):
        return vars[self.x]

    def __str__(self):
        return self.x


class true(Formula):
    def __init__(self):
        self.x = True

    def oblicz(self, vars):
        return True

    def __str__(self):
        return "true"


class false(Formula):
    def __init__(self):
        self.x = False

    def oblicz(self, vars):
        return False

    def __str__(self):
        return "false"


def var_list(f):
    def help(f, xs):
        if isinstance(f, Zmienna):
            xs.append(f.__str__())
        elif isinstance(f, Conj) or isinstance(f, Disj) or isinstance(f, Impl) or isinstance(f, Iff):
            help(f.left, xs)
            help(f.right, xs)
        return xs

    return help(f, [])


def tautology(f):
    v_list = var_list(f)
    for i in itertools.product([True, False], repeat=len(v_list)):
        vars = {}
        for j in range(len(v_list)):
            vars[v_list[j]] = i[j]
        if not f.oblicz(vars):
            return False
    return True


vars = {"x": False, "y": False, "z": False}

f1 = Impl(Zmienna("x"), Conj(Zmienna("y"), true()))

print(f1)
print(f1.oblicz(vars))
print(tautology(f1))
