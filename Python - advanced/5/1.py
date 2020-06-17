from math import sqrt
import timeit

def pierwsze_imperatywna(n):
    def is_prime(x):
        if x < 2:
            return False
        for i in range(2, int(sqrt(x)) + 1):
            if x % i == 0:
                return False
        return True

    res =[]
    for i in range(1, n + 1):
        if is_prime(i):
            res.append(i)

    return res


def pierwsze_skladana(n):
    return [x for x in range(2, n + 1) if len([y for y in range(2, int(sqrt(x)) + 1) if x % y == 0]) == 0]


def pierwsze_funkcyjna(n):
    return list(filter(lambda x: len(list(filter(lambda y: x % y == 0, range(2, int(sqrt(x)) + 1)))) == 0, range(2, n + 1)))

class Pierwsze:
    def __init__(self, n):
        self.liczba = 2
        self.limit = n

    def __iter__(self):
        return self

    def __next__(self):
        while True:
            if self.liczba > self.limit:
                raise StopIteration
            help = True
            for i in range(2, int(sqrt(self.liczba)) + 1):
                if self.liczba % i == 0:
                    help = False
                    break
            if help:
                self.liczba += 1
                return self.liczba - 1
            else:
                self.liczba += 1

def pierwsze_iterator(n):
    res = []
    x = Pierwsze(n)
    try:
        while True:
            res.append(x.__next__())
    except StopIteration:
        pass
    return res

print(pierwsze_imperatywna(101))
print(pierwsze_skladana(101))
print(pierwsze_funkcyjna(101))
print(pierwsze_iterator(101))


print()
print("       | imperatywna | funkcyjna |  skladana | iterator")

print("    10 |  %.7f  | %.7f | %.7f | %.7f" % ((timeit.Timer("pierwsze_imperatywna(10)", "from __main__ import pierwsze_imperatywna").timeit(1)),
                                             (timeit.Timer("pierwsze_funkcyjna(10)", "from __main__ import pierwsze_funkcyjna").timeit(1)),
                                             (timeit.Timer("pierwsze_skladana(10)", "from __main__ import pierwsze_skladana").timeit(1)),
                                             (timeit.Timer("pierwsze_iterator(10)", "from __main__ import pierwsze_iterator").timeit(1)))
      )

print("   100 |  %.7f  | %.7f | %.7f | %.7f" % ((timeit.Timer("pierwsze_imperatywna(100)", "from __main__ import pierwsze_imperatywna").timeit(1)),
                                             (timeit.Timer("pierwsze_funkcyjna(100)", "from __main__ import pierwsze_funkcyjna").timeit(1)),
                                             (timeit.Timer("pierwsze_skladana(100)", "from __main__ import pierwsze_skladana").timeit(1)),
                                             (timeit.Timer("pierwsze_iterator(100)", "from __main__ import pierwsze_iterator").timeit(1)))
      )

print("  1000 |  %.7f  | %.7f | %.7f | %.7f" % ((timeit.Timer("pierwsze_imperatywna(1000)", "from __main__ import pierwsze_imperatywna").timeit(1)),
                                             (timeit.Timer("pierwsze_funkcyjna(1000)", "from __main__ import pierwsze_funkcyjna").timeit(1)),
                                             (timeit.Timer("pierwsze_skladana(1000)", "from __main__ import pierwsze_skladana").timeit(1)),
                                             (timeit.Timer("pierwsze_iterator(1000)", "from __main__ import pierwsze_iterator").timeit(1)))
      )
