#include <iostream>
#include "punkt.hpp"
#include "prosta.hpp"
#include "wektor.hpp"

using namespace std;

bool proste_rownolegle(prosta k, prosta l){
        double kier_k =k.return_a()/k.return_b()*(-1);
        double kier_l =l.return_a()/l.return_b()*(-1);
        if(kier_k==kier_l){
            return true;
        }else{
            return false;
        }
}

bool proste_prostopadle(prosta k, prosta l){
        double kier_k =k.return_a()/k.return_b()*(-1);
        double kier_l =l.return_a()/l.return_b()*(-1);
        if(kier_k*kier_l==(-1)){
            return true;
        }else{
            return false;
        }
}

punkt punkt_przeciecia(prosta k, prosta l){
        if(proste_rownolegle(k,l)){
            throw std::invalid_argument("proste rownolegle nie maja punktu przeciecia!");
        }
        double b1 =(-1)*k.return_c()/k.return_b();
        double b2 =(-1)*l.return_c()/l.return_b();
        double a1 =(-1)*k.return_a()/k.return_b();
        double a2 =(-1)*l.return_a()/l.return_b();
        double x =(b1-b2)/(a2-a1);
        double y =(a2*b1-b2*a1)/(a2-a1);

        punkt p = punkt(x,y);
        return p;
}

wektor zloz_wektory(wektor w, wektor v){
        wektor u = wektor(w.return_dx()+v.return_dx(),w.return_dy()+v.return_dy());
        return u;
}

int main()
{

// TESTY:

// proste rownolegle

prosta k1 = prosta(1,2,5);
prosta k2 = prosta(-2,1,3);

if(proste_rownolegle(k1,k2)){
    cout << "proste: " << k1.return_a() << "x + " << k1.return_b()
         << "y + " << k1.return_c() << " = 0" << " oraz "
         << k2.return_a() << "x + " << k2.return_b()
         << "y + " << k2.return_c() << " = 0" << " sa rownolegle" << endl;
}else{
    cout << "proste: " << k1.return_a() << "x + " << k1.return_b()
         << "y + " << k1.return_c() << " = 0" << " oraz "
         << k2.return_a() << "x + " << k2.return_b()
         << "y + " << k2.return_c() << " = 0" << " nie sa rownolegle" << endl;
}

// proste prostopadle

if(proste_prostopadle(k1,k2)){
    cout << "proste: " << k1.return_a() << "x + " << k1.return_b()
         << "y + " << k1.return_c() << " = 0" << " oraz "
         << k2.return_a() << "x + " << k2.return_b()
         << "y + " << k2.return_c() << " = 0" << " sa prostopadle" << endl;
}else{
    cout << "proste: " << k1.return_a() << "x + " << k1.return_b()
         << "y + " << k1.return_c() << " = 0" << " oraz "
         << k2.return_a() << "x + " << k2.return_b()
         << "y + " << k2.return_c() << " = 0" << " nie sa prostopadle" << endl;
}

// skladanie wektorow

wektor w1=wektor(1,2);
wektor w2=wektor(-3,5);

wektor odp1=zloz_wektory(w1,w2);
cout << "zlozenie wektorow: [" << w1.dx << "," << w1.dy << "] oraz ["
     << w2.dx << "," << w2.dy << "] to wektor [" << odp1.dx
     << "," << odp1.dy << "]" << endl;

// punkt przeciecia

punkt odp2=punkt_przeciecia(k1,k2);
cout << "punkt przeciecia prostych: " << k1.return_a() << "x + "
     << k1.return_b() << "y + " << k1.return_c() << " = 0" << " oraz "
     << k2.return_a() << "x + " << k2.return_b() << "y + "
     << k2.return_c() << " = 0" << " to: (" << odp2.x << ","
     << odp2.y << ")" << endl;

// punkt przesuniety o wektor

punkt p1=punkt(-2,6);
wektor w3=wektor(2,-4);

punkt odp3=punkt(p1,w3);
cout << "punkt (" << p1.x << "," << p1.y << ") przesuniety o wektor ["
     << w3.dx << "," << w3.dy << "] to (" << odp3.x << ","
     << odp3.y << ")" << endl;

// prosta przechodzaca przez dwa punkty

punkt p2=punkt(2,-6);
prosta odp4=prosta(p1,p2);
cout << "prosta przechodzaca przez punkty: (" << p1.x << "," << p1.y
     << ") oraz (" << p2.x << "," << p2.y << ") ma rownanie: "
     << odp4.return_a() << "x + " << odp4.return_b() << "y + " << odp4.return_c() << " = 0" << endl;

// prosta wyznaczona przez wektor

prosta odp5=prosta(w1);
cout << "prosta wyznaczona przez wektor: [" << w1.dx << ","
     << w1.dy << "] ma rownanie: " << odp5.return_a() << "x + "
     << odp5.return_b() << "y + " << odp5.return_c() << " = 0" << endl;

// prosta przesunieta o wektor

prosta k3=prosta(-2,1,0);
prosta odp6=prosta(w1,k3);
cout << "prosta: " << k3.return_a() << "x + " << k3.return_b()
     << "y + " << k3.return_c() << " = 0" << " przesunieta o wektor ["
     << w1.dx << "," << w1.dy << "] ma rownanie: " << odp6.return_a()
     << "x + " << odp6.return_b() << "y + " << odp6.return_c()
     << " = 0" << endl;

// sprawdzenie czy wektor jest prostopadly do prostej

if(odp5.wektor_prostopadly(w1)){
    cout << "wektor [" << w1.dx << "," << w1.dy
         << "] jest prostopadly do prostej " << odp5.return_a()
         << "x + " << odp5.return_b() << "y + " << odp5.return_c()
         << " = 0" << endl;
}else{
    cout << "wektor [" << w1.dx << "," << w1.dy
         << "] nie jest prostopadly do prostej " << odp5.return_a()
         << "x + " << odp5.return_b() << "y + " << odp5.return_c()
         << " = 0" << endl;
}

// sprawdzenie czy wektor jest prostopadly do prostej

if(odp5.wektor_rownolegly(w1)){
    cout << "wektor [" << w1.dx << "," << w1.dy
         << "] jest rownolegly do prostej " << odp5.return_a()
         << "x + " << odp5.return_b() << "y + " << odp5.return_c()
         << " = 0" << endl;
}else{
    cout << "wektor [" << w1.dx << "," << w1.dy
         << "] nie jest rownolegly do prostej " << odp5.return_a()
         << "x + " << odp5.return_b() << "y + " << odp5.return_c()
         << " = 0" << endl;
}

// sprawdzenie czy punkt lezy na prostej

punkt p3=punkt(1,2);
if(odp5.punkt_na_prostej(p3)){
    cout << "punkt (" << p3.x << "," << p3.y << ") lezy na prostej: "
         << odp5.return_a() << "x + " << odp5.return_b()
         << "y + " << odp5.return_c() << " = 0" << endl;
}else{
    cout << "punkt (" << p3.x << "," << p3.y << ") nie lezy na prostej: "
         << odp5.return_a() << "x + " << odp5.return_b()
         << "y + " << odp5.return_c() << " = 0" << endl;
}

punkt as=punkt(1,2);
punkt asd=as;
cout << "(" << asd.x << ","
     << asd.y << ")" << endl;


    return 0;
}
