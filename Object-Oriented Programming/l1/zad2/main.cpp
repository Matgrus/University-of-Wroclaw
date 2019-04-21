#include <iostream>
#include "ulamki.hpp"

using namespace std;

int main()
{
    Ulamek* a = new Ulamek;
    a->licznik = -6;
    a->mianownik = 14;
    cout << "ulamek a:" << endl;
    wypisz(a);
    cout << "po skroceniu:" << endl;
    skroc(a);
    wypisz(a);

    Ulamek* b = new Ulamek;
    b->licznik = 4;
    b->mianownik = 14;
    cout << "ulamek b:" << endl;
    wypisz(b);

    cout << "c jako dodawanie a oraz b:" << endl;
    Ulamek* c = dodaj(a,b);
    wypisz(c);

    /*
    dodaj2(a,b);
    wypisz(a);
    wypisz(b);
    */

    cout << "d jako odejmowanie b oraz a:" << endl;
    Ulamek* d = odejmij(b,a);
    wypisz(d);

    cout << "e jako mnozenie a oraz b:" << endl;
    Ulamek* e = pomnoz(a,b);
    wypisz(e);

    cout << "f jako dzielenie a oraz b:" << endl;
    Ulamek* f = podziel(a,b);
    wypisz(f);

    return 0;
}
