#include "prosta.hpp"

double prosta::return_a(){
        return a;
}
double prosta::return_b(){
        return b;
}
double prosta::return_c(){
        return c;
}

prosta::prosta(punkt p1, punkt p2){
        if(p1.return_x()==p2.return_x() && p2.return_y()==p1.return_y()){
            throw std::invalid_argument("nie mozna jednoznacznie utworzyc prostej");
        }else{
            double a3 =(p2.return_y()-p1.return_y())/(p2.return_x()-p1.return_x());
            double b3 =p1.return_y()-a3*p1.return_x();
            a=(-1)*a3;
            b=1;
            c=(-1)*b3;
        }

}

prosta::prosta(wektor w){
        double x0=w.return_dx();
        double y0=w.return_dy();
        double a_w =(y0)/(x0);
        double a2 = (-1)/a_w;
        double b2 = y0+((-1)*a2*x0);
        a=(-1)*a2;
        b=1;
        c=(-1)*b2;
}

prosta::prosta(double a1, double b1, double c1){
        if (a1 == 0 && b1 == 0){
            throw std::invalid_argument("nie mozna jednoznacznie utworzyc prostej");
        }else{
            a=a1;
            b=b1;
            c=c1;
        }
}

prosta::prosta(wektor w, prosta k){
    double x0=w.return_dx();
    double y0=w.return_dy();
    double c4=((-1)*k.return_c()+y0+((-1)*k.return_a()*(-1)*x0))*(-1);
    a=k.return_a();
    b=k.return_b();
    c=c4;
}

bool prosta::wektor_prostopadly(wektor w){
        if (w.return_dx()==0 && w.return_dy()==0){
            throw std::invalid_argument("nie mozna sprawdzic wektora zerowego");
        }
        double kierunkowa_prostej=(a/b)*(-1);
        double kierunkowa_wektora =w.return_dy()/w.return_dx();
        if(kierunkowa_prostej*kierunkowa_wektora==(-1)){
            return true;
        }else{
            return false;
        }

}

bool prosta::wektor_rownolegly(wektor w){
        if (w.return_dx()==0 && w.return_dy()==0){
            throw std::invalid_argument("nie mozna sprawdzic wektora zerowego");
        }
        double kierunkowa_prostej=(a/b)*(-1);
        double kierunkowa_wektora =w.return_dy()/w.return_dx();
        if(kierunkowa_prostej==kierunkowa_wektora){
            return true;
        }else{
            return false;
        }

}

bool prosta::punkt_na_prostej(punkt p){
        if(a*p.return_x()+b*p.return_y()+c==0){
            return true;
        }else{
            return false;
        }
}
