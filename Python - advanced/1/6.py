def cyfry(x):
    res = 0
    while x > 0:
        x //= 10
        res += 1
    return res


def wypisz(x, l):
    for i in range(l - cyfry(x)):
        print(" ", end="")
    print(x, end=" ")


def tabliczka(start1, end1, start2, end2):
    maxx = cyfry(end1 * end2)
    for i in range(maxx + 1):
        print(" ", end="")
    for i in range(start1, end1 + 1):
        wypisz(i, maxx)
    for j in range(start2, end2 + 1):
        print()
        wypisz(j, maxx)
        for k in range(start1, end1 + 1):
            wypisz(k * j, maxx)


tabliczka(3, 5, 2, 4)
