
#ifndef wymierna_hpp
#define wymierna_hpp

#include <iostream>
#include<cmath>
#include<iomanip>

using namespace std;
namespace obliczenia{

class wymierna{
    private:
        int licz;
        int mian;

    public:
        wymierna(int licznik, int mianownik);
        wymierna(int liczba);
        wymierna(const wymierna &) = default;
        wymierna(wymierna &&) = default;
        int get_licznik() const;
        int get_mianownik() const;

        friend wymierna operator+(const wymierna &v, wymierna u);
        friend wymierna operator-(const wymierna &v, wymierna u);
        friend wymierna operator*(const wymierna &v, wymierna u);
        friend wymierna operator/(const wymierna &v, wymierna u);
        friend wymierna operator-(wymierna &a);
        friend wymierna operator!(wymierna &a);
        friend ostream &operator<<(ostream &wy, const wymierna &u);

        operator int const();
        explicit operator double const();

        int nwd(int a, int b);

    };
}


class wyjatek_wymierny: public exception{

};

class dziel_zero: public wyjatek_wymierny{
public:
    char const * what(){
        return "dzielenie przez zero";
    }

};

class przekroczenie_zakresu: public wyjatek_wymierny{
public:
    char const * what(){
        return "przekroczenie zakresu";
    }

};



#endif
