#ifndef wydarzenie_hpp
#define wydarzenie_hpp
#include "datagodz.hpp"


class wydarzenie{
public:
    datagodz punkt;
    std::string opis;

    wydarzenie();
    wydarzenie(datagodz x,std::string o);

    void print();


};


#endif
