#ifndef punkt_hpp
#define punkt_hpp
#include "wektor.hpp"
#include <iostream>

class punkt{

public:
    double x=0.0;
    double y=0.0;

    punkt()=default;
    punkt(double x1, double y1);
    punkt(punkt p, wektor w);
    punkt(const punkt &);
    punkt operator=(const punkt &)=delete;

    double return_x();
    double return_y();
};


#endif

