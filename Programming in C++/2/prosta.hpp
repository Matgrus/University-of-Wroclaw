#ifndef prosta_hpp
#define prosta_hpp
#include "wektor.hpp"
#include "punkt.hpp"
#include <stdexcept>
#include <iostream>


class prosta{

private:
    double a;
    double b;
    double c;

public:
    prosta(punkt p1,punkt p2);
    prosta(wektor w);
    prosta(double a1,double b1,double c1);
    prosta(wektor w, prosta k);
    prosta()=default;

    double return_a ();
    double return_b ();
    double return_c ();

    bool wektor_prostopadly(wektor w);
    bool wektor_rownolegly(wektor w);
    bool punkt_na_prostej(punkt p);
};


#endif

