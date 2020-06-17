from math import *


def czy_pierwsza(x):
    if x < 2:
        return False
    elif x == 2:
        return True
    else:
        for i in range(2, int(sqrt(x)) + 1):
            if x % i == 0:
                return False
    return True


def rozklad(n):
    if n <= 2:
        return [(n, 1)]
    res = []
    temp = 0
    i = 2
    while n > 1:
        if czy_pierwsza(i) and n % i == 0:
            while n % i == 0:
                n /= i
                temp += 1
            res.append((i, temp))
        else:
            temp = 0
            i += 1
    return res


print(rozklad(756))
