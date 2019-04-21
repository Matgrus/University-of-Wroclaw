#include "wydarzenie.hpp"
using namespace std;

wydarzenie::wydarzenie(){
   time_t now = time(0);
   tm *ltm = localtime(&now);
   int y= 1900 + ltm->tm_year;
   int mo= 1 + ltm->tm_mon;
   int d= ltm->tm_mday;
   int h= ltm->tm_hour;
   int mi= ltm->tm_min;
   int s= 1 + ltm->tm_sec;
   punkt=datagodz(d,mo,y,h,mi,s);
   opis="";
}

wydarzenie::wydarzenie(datagodz x,std::string o){
    punkt=x;
    opis=o;
}

void wydarzenie::print(){
    punkt.print();
    cout << "opis: " << opis << endl;
}




