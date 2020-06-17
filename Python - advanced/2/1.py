class Wyrazenie:
    pass


class Stala(Wyrazenie):
    def __init__(self, x):
        self.value = x

    def oblicz(self, x):
        return self.value


class Zmienna(Wyrazenie):
    def __init__(self, x):
        self.value = x

    def oblicz(self, x):
        return zmienne[self.value]


class Dodaj(Wyrazenie):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, x):
        return self.left.oblicz(x) + self.right.oblicz(x)


class Odejmij(Wyrazenie):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, x):
        return self.left.oblicz(x) - self.right.oblicz(x)


class Razy(Wyrazenie):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, x):
        return self.left.oblicz(x) * self.right.oblicz(x)


class Podziel(Wyrazenie):
    def __init__(self, x, y):
        self.left = x
        self.right = y

    def oblicz(self, x):
        return self.left.oblicz(x) / self.right.oblicz(x)


zmienne = {'x': 4}
print(zmienne)
o = Dodaj(Razy(Stala(9), Zmienna('x')), Stala(2))
print(o.oblicz(zmienne))