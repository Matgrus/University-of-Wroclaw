#include <iostream>
#include "ulamki.hpp"
#include <algorithm>

void skroc(Ulamek* u)
{
    int nwd = std::__gcd(u->licznik,u->mianownik);
    u->licznik = u->licznik/nwd;
    u->mianownik = u->mianownik/nwd;
    if(u->mianownik < 0){
        u->mianownik *= -1;
        u->licznik *= -1;
    }
}

void wypisz(Ulamek* a)
{
    std::cout << a->licznik << "/" << a->mianownik << std::endl;
}

Ulamek* dodaj(Ulamek* a, Ulamek* b)
{
    Ulamek* res = new Ulamek;
    res->licznik = a->licznik * b->mianownik + a->mianownik * b->licznik;
    res->mianownik = a->mianownik * b->mianownik;
    skroc(res);
    return res;
}

void dodaj2(Ulamek* a, Ulamek* b)
{
    b->licznik = a->licznik * b->mianownik + a->mianownik * b->licznik;
    b->mianownik = a->mianownik * b->mianownik;
    skroc(b);
}

Ulamek* odejmij(Ulamek* a, Ulamek* b)
{
    Ulamek* res = new Ulamek;
    res->licznik = a->licznik * b->mianownik - a->mianownik * b->licznik;
    res->mianownik = a->mianownik * b->mianownik;
    skroc(res);
    return res;
}

void odejmij2(Ulamek* a, Ulamek* b)
{
    b->licznik = a->licznik * b->mianownik - a->mianownik * b->licznik;
    b->mianownik = a->mianownik * b->mianownik;
    skroc(b);
}

Ulamek* pomnoz(Ulamek* a, Ulamek* b)
{
    Ulamek* res = new Ulamek;
    res->licznik = a->licznik * b->licznik;
    res->mianownik = a->mianownik * b->mianownik;
    skroc(res);
    return res;
}

void pomnoz2(Ulamek* a, Ulamek* b)
{
    b->licznik = a->licznik * b->licznik;
    b->mianownik = a->mianownik * b->mianownik;
    skroc(b);
}

Ulamek* podziel(Ulamek* a, Ulamek* b)
{
    Ulamek* res = new Ulamek;
    res->licznik = a->licznik * b->mianownik;
    res->mianownik = a->mianownik * b->licznik;
    skroc(res);
    return res;
}

void podziel2(Ulamek* a, Ulamek* b)
{
    b->licznik = a->licznik * b->mianownik;
    b->mianownik = a->mianownik * b->licznik;
    skroc(b);
}
