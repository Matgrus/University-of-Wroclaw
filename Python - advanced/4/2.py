import timeit

def doskonale_imperatywna(n):
    res = []
    for i in range(2, n + 1):
        sum = 0
        for j in range(i // 2 + 1, 0, -1):
            if i % j == 0:
                sum += j
                if sum > i:
                    break
        if sum == i:
            res.append(i)

    return res

def doskonale_skladana(n):
    return [x for x in range(1, n+1) if sum([y for y in range(1, x // 2 + 1) if x % y == 0]) == x]


def doskonale_funkcyjna(n):
    return list(filter(lambda x: sum(list(filter(lambda y: x % y == 0, range(1, x // 2 + 1)))) == x, range(2, n + 1)))

print(doskonale_imperatywna(10000))
print(doskonale_skladana(10000))
print(doskonale_funkcyjna(10000))

print()

print(timeit.Timer("doskonale_imperatywna(10000)", "from __main__ import doskonale_imperatywna").timeit(3))
print(timeit.Timer("doskonale_skladana(10000)", "from __main__ import doskonale_skladana").timeit(3))
print(timeit.Timer("doskonale_funkcyjna(10000)", "from __main__ import doskonale_funkcyjna").timeit(3))
