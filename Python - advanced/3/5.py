
def kompresja(tekst):
    aux = [tekst[0]]
    res = ""

    for i in range(1, len(tekst)):
        if tekst[i - 1] == tekst[i]:
            aux.append(tekst[i])
        else:
            res += str(len(aux)) + aux[0] if len(aux) > 1 else aux[0]
            aux = [tekst[i]]

    return res + str(len(aux)) + aux[0] if len(aux) > 1 else res + aux[0]

def dekompresja(tekst):
    res = ""
    aux = ""

    for i in range(len(tekst)):
        if tekst[i].isdigit():
            aux += tekst[i]
        else:
            res += tekst[i] if aux == "" else int(aux) * tekst[i]
            aux = ""

    return res

print(kompresja("suuuuper"))
print(kompresja("aaaaaaaaaaa"))
print(kompresja("asdfg"))
print(kompresja("aavaabgggt"))

print("=================")

print(dekompresja(kompresja("suuuuper")))
print(dekompresja(kompresja("aaaaaaaaaaa")))
print(dekompresja(kompresja("asdfg")))
print(dekompresja(kompresja("aavaabgggt")))