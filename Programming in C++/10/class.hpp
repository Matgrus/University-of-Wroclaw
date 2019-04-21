#ifndef class_hpp
#define class_hpp

#include <iostream>
#include <iomanip>

using namespace std;


    class myignore{
        int x;
        friend istream& operator>>(istream &is,const myignore &i);

    public:
        myignore(int x);
    };

    class myindex{
        int w,x;
        friend ostream& operator<<(ostream &os, const myindex &i);
    public:
        myindex(int x, int w);
    };


    #endif
