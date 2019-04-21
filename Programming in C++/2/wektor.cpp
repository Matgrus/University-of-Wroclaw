#include "wektor.hpp"

wektor::wektor(double x, double y){
        dx = x;
        dy = y;
}

wektor::wektor(const wektor &w) : dx(w.dx), dy(w.dy){
}

double wektor::return_dx(){
        return dx;
}

double wektor::return_dy(){
        return dy;
}
