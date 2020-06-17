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


print(pierwsze_imperatywna(101))
print(pierwsze_skladana(101))
print(pierwsze_funkcyjna(101))


print()

print(timeit.Timer("pierwsze_imperatywna(101)", "from __main__ import pierwsze_imperatywna").timeit(1000))
print(timeit.Timer("pierwsze_skladana(7)", "from __main__ import pierwsze_skladana").timeit(1000))
print(timeit.Timer("pierwsze_funkcyjna(101)", "from __main__ import pierwsze_funkcyjna").timeit(1000))
