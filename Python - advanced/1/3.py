def romb(n):
    h = 2 * n + 1
    i = 1
    while i <= h:
        for j in range((h - i) // 2):
            print(" ", end="")
        for j in range(i):
            print("#", end="")
        for j in range((h - i) // 2):
            print(" ", end="")
        print()
        i += 2
    i -= 4
    while i > 0:
        for j in range((h - i) // 2):
            print(" ", end="")
        for j in range(i):
            print("#", end="")
        for j in range((h - i) // 2):
            print(" ", end="")
        print()
        i -= 2


romb(4)
