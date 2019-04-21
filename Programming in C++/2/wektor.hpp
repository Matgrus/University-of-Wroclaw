#ifndef wektor_hpp
#define wektor_hpp

class wektor{

public:
    double dx=0;
    double dy=0;

    wektor()=default;
    wektor(double x, double y);
    wektor(const wektor &);
    wektor operator=(const wektor &)=delete;

    double return_dx();
    double return_dy();

};

#endif


