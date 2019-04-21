#include <iostream>
#include "data.hpp"
#include "datagodz.hpp"
#include "wydarzenie.hpp"

using namespace std;

int main()
{

data rok=data(20,02,1997);
rok.print();
data teraz=data();
cout << "aktualna data: ";
teraz.print();
data kopia=rok;
kopia.print();

data o1=data(12,1,0);
data o2=data(2,1,0);
cout << "wynik odejmowania: " << o1-o2 << endl;

data t1=data(1,3,2016);
data t2=data(31,12,2016);
t2++;
t2.print();
t1--;
t1.print();
t1+=12;
t1.print();

datagodz wyd=datagodz();
cout << "aktualna data i godzina: ";
wyd.print();

datagodz wyd2=datagodz(3,3,3,23,59,59);
wyd2++;
wyd2.print();

datagodz wyd3=datagodz(1,1,24,0,0,0);
wyd3--;
wyd3.print();

datagodz wyd4=datagodz(3,1,1,9,1,1);
datagodz wyd5=datagodz(3,1,1,1,1,1);
if(wyd4==wyd5){
    cout << "sa rowne" << endl;
}else{
    cout << "nie sa rowne" << endl;
}

if(wyd4<wyd5){
    cout << "jest mniejsza" << endl;
}else{
    cout << "nie jest mniejsza" << endl;
}

wydarzenie cos=wydarzenie(wyd3,"aaaaaaaa");
cos.print();

datagodz p1=datagodz(4,4,4,10,10,10);
datagodz p2=datagodz(4,4,4,10,10,5);

cout << "wynik odejmowania: " << p1-p2 << endl;

/*
data q1=data(21,12,1);
data q2=data(11,1,1);
q1+=20;
q1.print();
q2-=20;
q2.print();



datagodz z1=datagodz(1,1,1,10,10,10);
datagodz z2=datagodz(1,1,1,10,10,10);
z1+=3610;
z1.print();
z2-=3610;
z2.print();

*/

    return 0;

}
