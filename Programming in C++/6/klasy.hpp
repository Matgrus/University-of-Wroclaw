
#ifndef klasy_hpp
#define klasy_hpp

#include <cmath>
#include <stdexcept>
#include <string>
#include <vector>

class wyrazenie{
public:
    virtual double oblicz()=0;
    virtual std::string opis()=0;
};

class operator1arg: public wyrazenie{
public:
    std::string opis();

protected:
    wyrazenie *a;
};

class operator2arg: public operator1arg{
public:
    std::string opis();

protected:
    wyrazenie *b;

};

class stala: public wyrazenie{
public:
    virtual std::string opis();

};

class bezwgledna: public operator1arg{
public:
    double oblicz();
    bezwgledna(wyrazenie *a);
    std::string opis();


};

class cosinus: public operator1arg{
public:
    double oblicz();
    cosinus(wyrazenie *a);
    std::string opis();


};

class dodaj: public operator2arg{
public:
    virtual double oblicz();
    virtual std::string opis();
    dodaj(wyrazenie *a, wyrazenie *b);

};

class dziel: public operator2arg{
public:
    double oblicz();
    dziel(wyrazenie *a, wyrazenie *b);
    std::string opis();


};

class e: public stala{
public:
    double oblicz();
    std::string opis();


};

class exponent: public operator1arg{

public:
    double oblicz();
    exponent(wyrazenie *a);
    std::string opis();


};

class fi: public stala{
public:
    double oblicz();
    std::string opis();


};

class liczba: public wyrazenie{
public:
    virtual double oblicz();
    virtual std::string opis();
    liczba(int val);

private:
    int value;

};

class ln: public operator1arg{
public:
    double oblicz();
    ln(wyrazenie *a);
    std::string opis();

};

class logarytm: public operator2arg{
public:
    double oblicz();
    logarytm(wyrazenie *a, wyrazenie *b);
    std::string opis();

};

class mnoz: public operator2arg{
public:
    double oblicz();
    mnoz(wyrazenie *a, wyrazenie *b);
    std::string opis();

};

class modulo: public operator2arg{
public:
    double oblicz();
    modulo(wyrazenie *a, wyrazenie *b);
    std::string opis();

};

class odejmij: public operator2arg{

public:
    double oblicz();
    odejmij(wyrazenie *a, wyrazenie *b);
    std::string opis();

};

class odwrot: public operator1arg{
public:
    double oblicz();
    odwrot(wyrazenie *a);
    std::string opis();

};

class pi: public stala{
public:
    double oblicz();
    std::string opis();

};

class potega: public operator2arg{
public:
    double oblicz();
    potega(wyrazenie *a, wyrazenie *b);
    std::string opis();

};

class przeciw: public operator1arg{
public:
    double oblicz();
    przeciw(wyrazenie *a);
    std::string opis();

};

class sinus: public operator1arg{
public:
    double oblicz();
    sinus(wyrazenie *a);
    std::string opis();

};

class zmienna: public wyrazenie{
private:
    std::string value;
    std::vector<std::pair<std::string,double>> vars_tab;

public:
    virtual double oblicz();
    virtual std::string opis();
    void new_var(std::string x, double val);
    void set_value(double val);
    zmienna(const std::string &value);

};

#endif


