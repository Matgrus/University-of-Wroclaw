#include "class.hpp"


    myignore::myignore(int x) {
        this->x = x;
    }

    istream &operator>>(istream &is, const myignore &i){
        if(i.x == 0){
            return is;
        }
        int l = i.x;
        while(is && (is.get()!= '\n') && (l > 1)){
            l--;
        }
        return is;
    }

    myindex::myindex(int x, int w){
        this->x = x;
        this->w = w;
    }

    ostream &operator<<(ostream &os, const myindex &i){
        return os << "[" <<
               setw(i.w) << i.x << "]";
    }

