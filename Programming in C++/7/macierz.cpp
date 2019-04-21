#include "macierz.hpp"
namespace obliczenia{

macierz::macierz(int x){
    wiersz_wym=x;
    kolumna_wym=x;
    tablica = new double *[wiersz_wym];

    for (int i=0; i<wiersz_wym; i++){
        tablica[i] = new double [kolumna_wym];
    }

    for(int rzad=0; rzad<wiersz_wym; rzad++){
        for(int kol=0; kol<kolumna_wym; kol++){
            if(kol==rzad){
                tablica[rzad][kol]=1;
            }else{
                tablica[rzad][kol]=0;
            }
        }
    }
}

macierz::macierz(int x, int y){
    wiersz_wym=x;
    kolumna_wym=y;
    tablica = new double *[wiersz_wym];

    for (int i=0; i<wiersz_wym; i++){
        tablica[i] = new double [kolumna_wym];
    }

    for(int rzad=0; rzad<wiersz_wym; rzad++){
        for(int kol=0; kol<kolumna_wym; kol++){
            tablica[rzad][kol]=0;
        }
    }
}

macierz::macierz(const macierz& x):
    wiersz_wym(x.wiersz_wym), kolumna_wym(x.kolumna_wym), tablica(x.tablica){}

macierz & macierz::operator=(const macierz& x){
    wiersz_wym = x.wiersz_wym;
    kolumna_wym = x.kolumna_wym;
    tablica = x.tablica;
}

macierz::macierz(macierz&& x) : wiersz_wym(x.wiersz_wym), kolumna_wym(x.kolumna_wym), tablica(move(x.tablica)){
    x.tablica = nullptr;
}

macierz & macierz::operator=(macierz&& x){
    swap(kolumna_wym, x.kolumna_wym);
    swap(wiersz_wym, x.wiersz_wym);
    swap(tablica, x.tablica);
}

macierz::~macierz() {
    for (int i=0; i<wiersz_wym; i++){
        delete[] tablica[i];
    }
    delete[] tablica;
};

//operacje

void macierz::przestaw_wiersze(int a, int b){
    if(a>this->wiersz_wym || b>this->wiersz_wym
        || a<0 || b<0){
            throw ("wybrano zle wiersze");
    }
    double * help1 = this->tablica[a-1];
    double * help2 = this->tablica[b-1];
    this->tablica[a-1]=help2;
    this->tablica[b-1]=help1;
}

void macierz::przestaw_kolumny(int a, int b){
    if(a>this->kolumna_wym || b>this->kolumna_wym
        || a<0 || b<0){
            throw ("wybrano zle kolumny");
        }
    for(int i=0;i<this->wiersz_wym;i++){
        double h1=this->tablica[i][a-1];
        double h2=this->tablica[i][b-1];
        this->tablica[i][a-1]=h2;
        this->tablica[i][b-1]=h1;
    }
}

void macierz::pomnoz_wiersz(int a, double b){
    if(a>this->wiersz_wym || a<0){
            throw ("wybrano zly wiersz");
    }
    if(b==0){
        throw("przemnozono przez 0");
    }
    for(int i=0;i<this->kolumna_wym;i++){
        this->tablica[a-1][i]*=b;
    }
}

void macierz::pomnoz_kolumne(int a, double b){
    if(a>this->kolumna_wym || a<0){
            throw ("wybrano zla kolumne");
    }
    if(b==0){
        throw("przemnozono przez 0");
    }
    for(int i=0;i<this->wiersz_wym;i++){
        this->tablica[i][a-1]*=b;
    }
}

void macierz::dodaj_krotnosc_wiersza(int a, int b, double c){
    if(a>this->wiersz_wym || a<0 || b>this->wiersz_wym || b<0){
            throw ("wybrano zle wiersze");
    }
    if(c==0){
        throw("przemnozono przez 0");
    }
    for(int i=0;i<this->kolumna_wym;i++){
        this->tablica[a-1][i]+=this->tablica[b-1][i]*c;
    }
}

void macierz::dodaj_krotnosc_kolumny(int a, int b, double c){
    if(a>this->kolumna_wym || a<0 || b>this->kolumna_wym || b<0){
            throw ("wybrano zle kolumny");
    }
    if(c==0){
        throw("przemnozono przez 0");
    }
    for(int i=0;i<this->wiersz_wym;i++){
        this->tablica[i][a-1]+=this->tablica[i][b-1]*c;
    }
}

macierz macierz::laplace(int a, int b){
    if(this->wiersz_wym<2 || this->kolumna_wym<2){
        throw ("za mala macierz");
    }
    macierz test=*this;
    macierz wyn=macierz(this->wiersz_wym-1,this->kolumna_wym-1);
    int h1=0;
    int h2=0;
    for(int i=0;i<wyn.wiersz_wym;i++){
        if(i==a-1){
            h1++;
        }
        h2=0;
        for(int j=0;j<wyn.kolumna_wym;j++){
            if(j==b-1){
                h2++;
            }
            wyn.tablica[i][j]=test.tablica[h1][h2];
            h2++;
        }
        h1++;
    }
    return wyn;
}

double macierz::det(int n, int w, int * WK, macierz x){
        int i,j,k,m, * KK;
        double s;
        if(n == 1){
            return x.tablica[w][WK[0]];
        }else{
            KK = new int[n - 1];
            s = 0;
            m = 1;
            for(i = 0; i < n; i++){
                k = 0;
                for(j = 0; j < n - 1; j++){
                    if(k == i){
                        k++;
                    }
                    KK[j] = WK[k++];
                }
                s += m * x.tablica[w][WK[i]] * det(n - 1,w  + 1, KK, x);
                m = -m;
            }
            delete [] KK;
            return s;
        }
    }

double macierz::wyznacznik(){
    if(this->wiersz_wym!=this->kolumna_wym){
        throw ("macierz nie jest kwadratowa");
    }
    int n=this->wiersz_wym;
    int * WK = new int[n];
    for(int i = 0; i < n; i++){
        WK[i] = i;
    }
    return det(n, 0, WK, *this);
}

macierz macierz::odwrotna(){
    if(this->wiersz_wym!=this->kolumna_wym){
        throw ("macierz nie jest kwadratowa");
    }
    macierz test=*this;
    double wyzn=test.wyznacznik();
    if(wyzn==0){
        throw ("wyznacznik jest rowny 0");
    }
    macierz dop=macierz(this->wiersz_wym,this->kolumna_wym);
    for(int i=0;i<dop.wiersz_wym;i++){
        for(int j=0;j<dop.kolumna_wym;j++){
            dop.tablica[i][j]=test.laplace(i+1,j+1).wyznacznik()*pow(-1,i+j);
        }
    }
    dop=!dop;
    dop%=pow(wyzn,-1);
    return dop;
}

// operatory

macierz & macierz::operator+=(const macierz &y){
    if(this->wiersz_wym!=y.wiersz_wym || this->kolumna_wym!=y.kolumna_wym){
        throw ("zle wymiary macierzy");
    }
    macierz wyn=*this;
    for(int i=0;i<y.wiersz_wym;i++){
        for(int j=0;j<y.kolumna_wym;j++){
            wyn.tablica[i][j]=this->tablica[i][j]+y.tablica[i][j];
        }
    }
    return wyn;
}

macierz & macierz::operator-=(const macierz &y){
    if(this->wiersz_wym!=y.wiersz_wym || this->kolumna_wym!=y.kolumna_wym){
        throw ("zle wymiary macierzy");
    }
    macierz wyn=*this;
    for(int i=0;i<y.wiersz_wym;i++){
        for(int j=0;j<y.kolumna_wym;j++){
            wyn.tablica[i][j]=this->tablica[i][j]-y.tablica[i][j];
        }
    }
    return wyn;
}

macierz & macierz::operator*=(const macierz &y){
    if(this->kolumna_wym!=y.wiersz_wym){
        throw ("zle wymiary macierzy");
    }
    macierz wyn=macierz(this->wiersz_wym,y.kolumna_wym);
    for(int i=0;i<this->wiersz_wym;i++){
        for(int j=0;j<y.kolumna_wym;j++){
            double sum=0;
            for(int k=0;k<y.wiersz_wym;k++){
                sum+=this->tablica[i][k]*y.tablica[k][j];
            }
            wyn.tablica[i][j]=sum;
        }
    }
    return wyn;
}

macierz & macierz::operator%=(const double &k){
    macierz wyn=*this;
    for(int i=0;i<this->wiersz_wym;i++){
        for(int j=0;j<this->kolumna_wym;j++){
            wyn.tablica[i][j]=wyn.tablica[i][j]*k;
        }
    }
    return wyn;
}

}
