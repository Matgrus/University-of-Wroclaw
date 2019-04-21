#include "figura.hpp"
#include <iostream>
#include <cmath>
# define M_PI 3.14159265358979323846

float pole(Figura *f){
    switch(f->typ){
        case trojkat:
            {
            float a = sqrt(pow(abs(f->ax - f->bx),2)+pow(abs(f->ay - f->by),2));
            float b = sqrt(pow(abs(f->bx - f->cx),2)+pow(abs(f->by - f->cy),2));
            float c = sqrt(pow(abs(f->cx - f->ax),2)+pow(abs(f->cy - f->ay),2));
            float p = 0.5*(a+b+c);
            return sqrt(p*(p-a)*(p-b)*(p-c));
            }
        case kolo:
            return M_PI*(f->r * f->r);
        case kwadrat:
            return (f->bx - f->ax)*(f->by - f->ay);
    }
}

void przesun(Figura *f, float x, float y){
    switch(f->typ){
        case trojkat:
            f->ax = f->ax + x;
            f->ay = f->ay + y;
            f->bx = f->bx + x;
            f->by = f->by + y;
            f->cx = f->cx + x;
            f->cy = f->cy + y;
            break;
        case kolo:
            f->ax = f->ax + x;
            f->ay = f->ay + y;
            break;
        case kwadrat:
            f->ax = f->ax + x;
            f->ay = f->ay + y;
            f->bx = f->bx + x;
            f->by = f->by + y;
    }
}

float sumapol(Figura *f, int size){
    float wynik = 0.0;
    for(int i=0; i<size; i++){
        wynik += pole(&f[i]);
    }
    return wynik;
}

Figura Kwadrat(float ax, float ay, float bx, float by){
    if(ax == bx || ay == by){
        std::cout << "to nie jest poprawny kwadrat!" << std::endl;
    }else{
    Figura a;
    a.typ = kwadrat;
    a.ax = ax;
    a.ay = ay;
    a.bx = bx;
    a.by = by;
    return a;
    }
}

Figura Kolo(float ax, float ay, float r){
    if(r<0){
        std::cout << "to nie jest kolo!" << std::endl;
    }else{
        Figura a;
        a.typ = kolo;
        a.ax = ax;
        a.ay = ay;
        a.r = r;
        return a;
    }
}

Figura Trojkat(float ax, float ay, float bx, float by, float cx, float cy){
    float a = sqrt(pow(abs(ax - bx),2)+pow(abs(ay - by),2));
    float b = sqrt(pow(abs(bx - cx),2)+pow(abs(by - cy),2));
    float c = sqrt(pow(abs(cx - ax),2)+pow(abs(cy - ay),2));
    if(a+b > c && a+c > b && b+c > a){
        Figura a;
        a.typ = trojkat;
        a.ax = ax;
        a.ay = ay;
        a.bx = bx;
        a.by = by;
        a.cx = cx;
        a.cy = cy;
        return a;
    }else{
        std::cout << "to nie jest poprawny trojkat!" << std::endl;
    }
}
