import itertools


def kryptarytm(arg1, arg2, res):
    letters = list(set(arg1 + arg2 + res))
    perm_list = list(itertools.permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], len(letters)))
    for j in range(len(perm_list)):
        dict = {}
        for i in range(len(letters)):
            dict[letters[i]] = perm_list[j][i]
        if dict[arg1[0]] == 0 or dict[arg2[0]] == 0 or dict[res[0]] == 0:
            continue
        v1 = ""
        v2 = ""
        r = ""
        for k in range(len(arg1)):
            v1 += str(dict[arg1[k]])
        for l in range(len(arg2)):
            v2 += str(dict[arg2[l]])
        for m in range(len(res)):
            r += str(dict[res[m]])
        if int(v1) + int(v2) == int(r):
            break

    print(int(v1),"+", int(v2),"=", int(r))

    return dict


print(kryptarytm("send", "more", "money"))
print(kryptarytm("lok", "oko", "lala"))
print(kryptarytm("trzy", "trzy", "sześć"))
print(kryptarytm("kioto", "osaka", "tokio"))
print(kryptarytm("skirt", "tshirt", "clothes"))

