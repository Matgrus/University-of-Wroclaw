#include <iostream>
#include "klasy.hpp"
#include "klasy.hpp"

using namespace std;

int main()
{
    //dodawanie
    wyrazenie *a = new dodaj( new liczba(3), new liczba(3));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //odejmowanie
    a = new odejmij( new liczba(3), new liczba(3));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //mnozenie
    a = new mnoz( new liczba(3), new liczba(3));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //dzielenie
    a = new dziel( new liczba(3), new liczba(3) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //potegowanie
    a = new potega( new liczba(3), new liczba(3) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //logarytm
    a = new logarytm( new liczba(4), new liczba(16));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //modulo
    a = new modulo( new liczba(2), new liczba(1));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //logarytm naturalny
    a = new ln(new liczba(1));
    cout << a->opis() << " = " << a->oblicz() << endl;

    //wartosc bezwzgledna
    a = new bezwgledna( new liczba(-11) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //odwrotnosc
    a = new odwrot( new liczba(2) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //exp
    a = new exponent( new liczba(1) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //cosinus
    a = new cosinus( new liczba(0) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //sinus
    a = new sinus( new liczba(0) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //przeciwna
    a = new przeciw( new liczba(3) );
    cout << a->opis() << " = " << a->oblicz() << endl;

    //pi
    a = new pi();
    cout << a->opis() << " = " << a->oblicz() << endl;

    //e
    a = new e();
    cout << a->opis() << " = " << a->oblicz() << endl;

    //fi
    a = new fi();
    cout << a->opis() << " = " << a->oblicz() << endl;

    //zmienna
    zmienna *x = new zmienna("x");
    cout << x->opis() << " = " << x->oblicz() << endl;
    x->set_value((double) 1/100);
    cout << x->opis() << " = " << x->oblicz() << endl;


    cout << "=============" << endl;


    // A: ((x-1)*x)/2
    a = new dziel(
            new mnoz(
                new odejmij(x,new liczba(1)),
                x),
            new liczba(2));

    cout << "A: " << a->opis() << endl;

    for(int i = 0; i < 101; ++i){
        x->set_value((double) i/100 );
        cout << i+1 << ": " << a->oblicz() << endl;
    }


    // B: (3+5)/(2+x*7)
    wyrazenie *b = new dziel(
                        new dodaj(
                            new liczba(3),
                            new liczba(5)),
                        new dodaj(
                            new liczba(2),
                            new mnoz(x,new liczba(7))));

    cout << "B: " << b->opis() << endl;

    for(int i = 0; i < 101; ++i){
        x->set_value((double) i/100 );
        cout << i+1 << ": " << b->oblicz() << endl;
    }


    // C: 2+x*7-(y*3+5)
    wyrazenie *c = new odejmij(
                        new dodaj(
                            new liczba(2),
                            new mnoz(x,new liczba(7))),
                        new dodaj(
                            new mnoz(new zmienna("y"),new liczba(3)),
                            new liczba(5)));

    cout << "C: " << c->opis() << endl;
    for(int i = 0; i < 101; ++i){
        x->set_value((double) i/100 );
        cout << i+1 << ": " << c->oblicz() << endl;
    }


    // D: cos((x+1)*x)/e^x^2
    wyrazenie *d = new dziel(
                        new cosinus(new mnoz(new dodaj(x,new liczba(1)),x)),
                        new potega(new e(),new potega(x,new liczba(2))));

    cout << "D: " << d->opis() << endl;
    for(int i = 0; i < 101; ++i){
        x->set_value((double) i/100 );
        cout << i+1 << ": " << d->oblicz() << endl;
    }

    return 0;
}
