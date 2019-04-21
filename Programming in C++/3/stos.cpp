#include "stos.hpp"

stos::stos(){
    pojemnosc =1;
    ile = 0;
    napis = new string[pojemnosc];
}

stos::~stos() {
    delete[] napis;
};

stos::stos(int poj){
    pojemnosc = poj;
    ile = 0;
    napis = new string[poj];
}

stos::stos(initializer_list<string> s){
    napis = new string[s.size()];
    pojemnosc = s.size()+100;
    ile=0;
    for(auto x : s){
        wloz(x);
    }
}

stos::stos(const stos& x): pojemnosc(x.pojemnosc), ile(x.ile){
    copy(x.napis, x.napis + x.ile, napis);
}

stos & stos::operator=(const stos& x){
    pojemnosc = x.pojemnosc;
    ile = x.ile;
    napis = new string[pojemnosc];
    copy(x.napis, x.napis + x.ile, napis);
}

stos::stos(stos&& x) : ile(x.ile), pojemnosc(x.pojemnosc), napis(move(x.napis)){
    x.napis = nullptr;
}

stos & stos::operator=(stos&& x){
    swap(pojemnosc, x.pojemnosc);
    swap(ile, x.ile);
    swap(napis, x.napis);
}

void stos::wloz(string s){
    if(ile<pojemnosc){
        napis[ile]=s;
        ile++;
    }else{
    throw range_error("stos jest pelny!");
    }
}

string stos::sciagnij(){
    if(ile==0){
         throw range_error("stos jest pusty!");
    }else{
        ile--;
        return napis[ile];
    }
}

string stos::sprawdz(){
    if(ile == 0){
        cout << "stos jest pusty!" << endl;
    }else{
    return napis[ile-1];
    }
}

int stos::rozmiar(){
    return ile;
}

void stos::wypisz(){
    for(int i=0;i<ile;++i){
        cout << napis[i] << endl;
    }
}

int stos::poj(){
    return pojemnosc;
}
