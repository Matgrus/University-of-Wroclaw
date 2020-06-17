
def pierwiastek(n):
    sum = 0
    i = 0
    s = 1
    while sum <= n:
        sum += s
        s += 2
        i += 1

    return i - 1

