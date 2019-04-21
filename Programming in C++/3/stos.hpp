#ifndef stos_hpp
#define stos_hpp
#include <iostream>

using namespace std;

class stos{

private:
    int pojemnosc;
    int ile;

public:
    string *napis;

    stos();
    ~stos();
    stos(int poj);
    stos(initializer_list<string>);
    stos(const stos& x);
    stos& operator=(const stos& x);
    stos (stos&& x);
    stos& operator=(stos&& x);
    void wloz(string s);
    string sciagnij();
    string sprawdz();
    int rozmiar();
    void wypisz();
    int poj();
};

#endif
