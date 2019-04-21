
#include "wymierna.hpp"

using namespace obliczenia;

wymierna::wymierna(int licznik, int mianownik){
    try{
        if(mianownik==0){
            throw dziel_zero();
        }
    }
    catch(dziel_zero& e){
        std::cerr << e.what() << endl;
    }
    if(licznik==0){
        licz=licznik;
        mian=mianownik;
    }else if(nwd(licznik, mianownik)!=1){
        licz=licznik/nwd(licznik,mianownik);
        mian=mianownik/nwd(licznik,mianownik);
    }else if(mianownik<0){
        licz=licznik*(-1);
        mian=mianownik*(-1);
    }else{
        licz=licznik;
        mian=mianownik;
    }
}

wymierna::wymierna(int liczba){
    licz=liczba;
    mian=1;
}

int wymierna::get_licznik() const{
    return licz;
}

int wymierna::get_mianownik() const{
    return mian;
}

int wymierna::nwd(int a, int b){
    a = abs(a);
    b = abs(b);
    while(a!=b)
        if(a>b)
            a-=b;
        else
            b-=a;
    return a;
}

wymierna::operator int const(){
    return licz/mian;
}

wymierna::operator double const(){
    return 1.0*licz/mian;
}

namespace obliczenia{

wymierna operator+(const wymierna &v, wymierna u){
    return wymierna(v.licz*u.mian+u.licz*v.mian,v.mian*u.mian);
}


wymierna operator-(const wymierna &v, wymierna u){
    return wymierna(v.licz*u.mian-u.licz*v.mian,v.mian*u.mian);
}

wymierna operator*(const wymierna &v, wymierna u){
    return wymierna(v.licz*u.licz,v.mian*u.mian);
}

wymierna operator/(const wymierna &v, wymierna u){
    return wymierna(v.licz*u.mian,v.mian*u.licz);
}


wymierna operator-(wymierna &a){
    return wymierna(a.licz*(-1),a.mian);
}

wymierna operator!(wymierna &a){
    if(a.licz<0){
        return wymierna(a.mian*(-1),a.licz*(-1));
    }else{
        return wymierna(a.mian,a.licz);
    }
}

ostream& operator << (ostream &wy, const wymierna &w){
    return wy << 1.0*w.licz/w.mian;
}


}

