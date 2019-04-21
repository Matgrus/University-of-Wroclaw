#include "punkt.hpp"

punkt::punkt(double x1, double y1){
        x = x1;
        y = y1;
}

punkt::punkt(punkt p, wektor w){
        x=p.return_x()+w.return_dx();
        y=p.return_y()+w.return_dy();
}

punkt::punkt(const punkt &p) : x(p.x), y(p.y){
}

double punkt::return_x(){
        return x;
}

double punkt::return_y(){
        return y;
}
