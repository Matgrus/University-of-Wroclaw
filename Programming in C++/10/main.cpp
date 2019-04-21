#include <iostream>
#include <iomanip>

#include "class.hpp"

using namespace std;

inline istream& clearline(istream &is){
    while(is){
        if(is.get()=='\n'){
            return is;
        }
    }
}

inline ostream& comma(ostream &os){
    return os << ", ";
}

inline ostream& colon(ostream &os){
    return os << ": ";
}

int main(){

string x;
cin >> clearline >> myignore(2) >> x;
cout << "wynik to" << colon << x << endl;

cout << myindex(34,3) << endl;

    return 0;
}

