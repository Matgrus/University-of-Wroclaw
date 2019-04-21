#ifndef data_hpp
#define data_hpp
#include <stdexcept>
#include <ctime>
#include <iostream>


class data{
public: // zmienic na private
    bool czy_poprawna(int d, int m, int y);
    int ile_dni(data x);

protected:
    int day;
    int month;
    int year;

    static bool czy_przest(int y);

public:
    int return_day();
    int return_month();
    int return_year();

    data();
    data(int d, int m, int y);

    data(const data &);
    data& operator=(const data& x);

    static int dniwmiesiacach[2][13];
    static int dniodpoczroku[2][13];

    virtual int operator-(const data& x);
    data& operator ++(int);
    data& operator --(int);
    data& operator +=(const int& x);
    data& operator -=(const int& x);

    void print();

};




#endif

