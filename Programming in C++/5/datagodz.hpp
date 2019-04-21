#ifndef datagodz_hpp
#define datagodz_hpp
#include "data.hpp"

class datagodz final: protected data{
protected:
    int hour;
    int minute;
    int second;

public:
    int return_hour();
    int return_minute();
    int return_second();

    datagodz();
    //datagodz(int d=1, int mo=1, int y=0, int h=12, int mi=12, int s=12);
    datagodz(int d, int mo, int y, int h, int mi, int s);

    datagodz& operator ++(int);
    datagodz& operator --(int);
    datagodz& operator +=(const int& x);
    datagodz& operator -=(const int& x);
    bool operator==(const datagodz& x);
    bool operator<(const datagodz& x);
    int operator-(const datagodz& x);

    void print();


};


#endif

