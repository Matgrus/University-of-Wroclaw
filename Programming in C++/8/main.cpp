#include <iostream>
#include "wymierna.hpp"

using namespace obliczenia;
using namespace std;

int main()
{
    wymierna a=obliczenia::wymierna(4);
    wymierna b=obliczenia::wymierna(2,6);
    cout << b.get_licznik() << endl;
    cout << b.get_mianownik() << endl;
    cout << a << endl;
    cout << b << endl;
    cout << a+b << endl;
    cout << b-a << endl;
    cout << b/a << endl;
    cout << a*b << endl;
    cout << -a*b << endl;
    cout << !b << endl;
    cout << int(b) << endl;
    cout << double(a) << endl;
    cout << static_cast<double>(b) << endl;
    wymierna c=wymierna(1,2);
    wymierna d=wymierna(6,8);
    cout << c+d << endl;

    return 0;
}
