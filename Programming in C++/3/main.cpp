#include <iostream>
#include "stos.hpp"

using namespace std;

int main() {

    //poczatek

    stos a=stos(100);
    cout << "liczba elementow na stosie a: " << a.rozmiar() << endl;
    cout << "pojemnosc stosu a to: " << a.poj() << endl;
    a.wloz("jeden");
    a.wloz("dwa");
    a.wypisz();
    cout << "liczba elementow na stosie a: " << a.rozmiar() << endl;
    cout << "pojemnosc stosu a to: " << a.poj() << endl;

    cout << "----------" << endl;

    //kopiowanie

    stos b;
    //b.sciagnij();
    cout << "liczba elementow na stosie b: " << b.rozmiar() << endl;
    cout << "pojemnosc stosu b to: " << b.poj() << endl;
    b=a;
    b.wypisz();
    cout << "liczba elementow na stosie b: " << b.rozmiar() << endl;
    cout << "pojemnosc stosu b to: " << b.poj() << endl;

    cout << "-------------" << endl;

    a.wloz("trzy");
    a.wloz("cztery");
    a.wloz("piec");
    cout << "liczba elementow na stosie a: " << a.rozmiar() << endl;
    cout << "pojemnosc stosu a to: " << a.poj() << endl;
    a.wypisz();

    cout << "----------" << endl;

    // sciagnij, wypisz

    a.sciagnij();
    cout << "liczba elementow na stosie a: " << a.rozmiar() << endl;
    cout << "pojemnosc stosu a to: " << a.poj() << endl;
    a.wypisz();

    cout << "----------" << endl;

    // sprawdz

    cout << "na wierzchu lezy: " << a.sprawdz() << endl;
    a.sciagnij();
    cout << "na wierzchu lezy: " << a.sprawdz() << endl;

    cout << "----------" << endl;

    // z tablicy

    stos tt={"one","two","three"};
    tt.wypisz();
    cout << "liczba elementow na stosie tt: " << tt.rozmiar() << endl;
    cout << "pojemnosc stosu tt to: " << tt.poj() << endl;
}
