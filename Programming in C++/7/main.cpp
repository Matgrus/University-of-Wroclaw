#include <iostream>
#include "macierz.hpp"

using namespace std;
using namespace obliczenia;

int main()
{

    cout << "podaj wymiar macierzy" << endl;
    int n;
    cin >> n;

    cout << "podaj kolejne wartosci macierzy" << endl;
    macierz m4=macierz(n,n);
    cin >> m4;
    cout << "macierz: " << endl << m4 << endl;

    cout << "wyznacznk: " << m4.wyznacznik() << endl;

    cout << "odwrotna; " << endl << m4.odwrotna() << endl;

    return 0;
}
