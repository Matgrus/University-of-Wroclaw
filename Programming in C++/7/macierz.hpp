
#ifndef macierz_hpp
#define macierz_hpp

#include <iostream>
#include <cmath>

using namespace std;
namespace obliczenia{
class macierz{
private:
    int wiersz_wym;
    int kolumna_wym;
    double** tablica;

public:
    macierz(int x);
    macierz(int x, int y);

    macierz(const macierz &);
    macierz& operator=(const macierz& x);
    macierz (macierz&& x);
    macierz& operator=(macierz&& x);
    ~macierz();

    //operacje

    void przestaw_wiersze(int a, int b);
    void przestaw_kolumny(int a, int b);
    void pomnoz_wiersz(int a, double b);
    void pomnoz_kolumne(int a, double b);
    void dodaj_krotnosc_wiersza(int a, int b, double c);
    void dodaj_krotnosc_kolumny(int a, int b, double c);
    macierz laplace(int a, int b);

    double wyznacznik();
    double det(int n, int w, int * WK, macierz x);

    macierz odwrotna();

    //operatory
    friend macierz operator+ (const macierz &x, const macierz &y){
        if(x.wiersz_wym!=y.wiersz_wym || x.kolumna_wym!=y.kolumna_wym){
            throw ("zle wymiary macierzy");
        }
        macierz wyn=macierz(x.wiersz_wym,x.kolumna_wym);
        for(int i=0;i<x.wiersz_wym;i++){
            for(int j=0;j<x.kolumna_wym;j++){
            wyn.tablica[i][j]=x.tablica[i][j]+y.tablica[i][j];
            }
        }
        return wyn;
    }
    macierz & operator+= (const macierz &y);

    friend macierz operator- (const macierz &x, const macierz &y){
        if(x.wiersz_wym!=y.wiersz_wym || x.kolumna_wym!=y.kolumna_wym){
            throw ("zle wymiary macierzy");
        }
        macierz wyn=macierz(x.wiersz_wym,x.kolumna_wym);
        for(int i=0;i<x.wiersz_wym;i++){
            for(int j=0;j<x.kolumna_wym;j++){
            wyn.tablica[i][j]=x.tablica[i][j]-y.tablica[i][j];
            }
        }
        return wyn;
    }
    macierz & operator-= (const macierz &y);

    friend macierz operator* (const macierz &x, const macierz &y){
        if(x.kolumna_wym!=y.wiersz_wym){
            throw ("zle wymiary macierzy");
        }
        macierz wyn=macierz(x.wiersz_wym,y.kolumna_wym);
        for(int i=0;i<x.wiersz_wym;i++){
            for(int j=0;j<y.kolumna_wym;j++){
                double sum=0;
                for(int k=0;k<y.wiersz_wym;k++){
                    sum+=x.tablica[i][k]*y.tablica[k][j];
                }
                wyn.tablica[i][j]=sum;
            }
        }
        return wyn;
    }
    macierz & operator*= (const macierz &y);

    friend macierz operator! (const macierz &x){ //transpozycja
        if(x.wiersz_wym!=x.kolumna_wym){
            throw ("zle wymiary macierzy");
        }
        macierz wyn=macierz(x.wiersz_wym,x.kolumna_wym);
        for(int i=0;i<x.wiersz_wym;i++){
            for(int j=0;j<x.kolumna_wym;j++){
                wyn.tablica[i][j]=x.tablica[j][i];
            }
        }
        return wyn;
    }

    friend macierz operator% (const macierz &x, const double &k){
        macierz wyn=macierz(x.wiersz_wym,x.kolumna_wym);
        for(int i=0;i<x.wiersz_wym;i++){
            for(int j=0;j<x.kolumna_wym;j++){
                wyn.tablica[i][j]=x.tablica[i][j]*k;
            }
        }
        return wyn;
    }
    macierz & operator%= (const double &k); //skalar

    friend istream& operator>> (istream &we, macierz &x){
        for(int i=0; i<x.wiersz_wym;i++){
            for(int j=0; j<x.kolumna_wym;j++){
                we >> x.tablica[i][j];
            }
        }
        return we;
    }

    friend ostream& operator<< (ostream &wy, const macierz &x){
        for(int i=0; i<x.wiersz_wym;i++){
            for(int j=0; j<x.kolumna_wym;j++){
                wy << x.tablica[i][j] << ", ";
                if(j==x.kolumna_wym-1){
                    wy << endl;
                }
            }
        }
        return wy;
    }

};

}
#endif
