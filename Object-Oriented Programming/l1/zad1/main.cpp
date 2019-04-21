#include <iostream>
#include "figura.hpp"

using namespace std;

int main()
{
    Figura kwadrat = Kwadrat(2,2,5,5);
    cout << pole(&kwadrat) << endl;

    Figura kolo = Kolo(0,0,7);
    cout << pole(&kolo) << endl;

    Figura trojkat = Trojkat(0,2,-6,-6,8,0);
    cout << pole(&trojkat) << endl;

    Figura figury[3] = {kwadrat, kolo, trojkat};
    cout << sumapol(figury,3) << endl;

    Figura tr = Trojkat(0,0,0,4,0,2);
    Figura ko = Kolo(0,0,-1);
    Figura kw = Kwadrat(0,5,4,5);

    return 0;
}
