#include "data.hpp"
using namespace std;


int data::return_day(){
    return day;
}
int data::return_month(){
    return month;
}
int data::return_year(){
    return year;
}

data::data(int d, int m, int y){
    if(czy_poprawna(d,m,y)){
        day=d;
        month=m;
        year=y;
    }else{
        throw std::invalid_argument("zla data");
    }

}

bool data::czy_przest(int y){
    if(y%400==0){
        return true;
    }else if(y%4==0 && y%100!=0){
        return true;
    }else{
        return false;
    }
}

int data::dniwmiesiacach[2][13] = {
        {0,31,28,31,30,31,30,31,31,30,31,30,31}, // lata zwyk³e
        {0,31,29,31,30,31,30,31,31,30,31,30,31} // lata przestêpne
};

bool data::czy_poprawna(int d, int m, int y){
    if(d<=dniwmiesiacach[czy_przest(y)][m] && d>=1){
        return true;
    }else{
        return false;
    }
}

data::data(){
    time_t now=time(0);
    tm *ltm = localtime(&now);
    year= 1900 + ltm->tm_year;
    month= 1 + ltm->tm_mon;
    day= ltm->tm_mday;
}

data::data(const data& x): day(x.day), month(x.month), year(x.year){}

data & data::operator=(const data& x){
    day = x.day;
    month = x.month;
    year = x.year;
}

int data::dniodpoczroku[2][13] = {
    {0,31,59,90,120,151,181,212,243,273,304,334,365}, // lata zwyk³e
    {0,31,60,91,121,152,182,213,244,274,305,335,366} // lata przestêpne
};

int data::ile_dni(data x){
    int wynik=dniodpoczroku[czy_przest(x.return_year())][x.return_month()-1]+x.return_day();
    int help=(((x.return_year()/4)-(x.return_year()/100))+(x.return_year()/400));
    wynik+=(help*366)+((x.return_year()-help)*365);
    return wynik;
}

int data::operator-(const data& x){
    return abs(ile_dni(x)-ile_dni(data(this->day,this->month,this->year)));
}

data& data::operator++(int){
    if(czy_poprawna(day+1,month,year)){
        day++;
        return *this;
    }else if(czy_poprawna(day,month+1,year)){
        day=1;
        month++;
        return *this;
    }else{
        day=1;
        month=1;
        year++;
        return *this;
    }
}

data& data::operator--(int){
    if(czy_poprawna(day-1,month,year)){
        day--;
        return *this;
    }else if(czy_poprawna(dniwmiesiacach[czy_przest(year)][month-1],month-1,year)){
        day=dniwmiesiacach[czy_przest(year)][month-1];
        month--;
        return *this;
    }else{
        day=31;
        month=12;
        year--;
        return *this;
    }
}

data& data::operator+=(const int& x){
    int help=0;
    day+=x;
    int licz=0;
    while (help!=1){
        if(czy_poprawna(day,month,year)){
            help=1;
        }else{
            licz=day-dniwmiesiacach[czy_przest(year)][month];
            day=licz;
            month++;
            if(month>12){
                month=0;
                year++;
            }
        }
    }
    return *this;
}

data& data::operator-=(const int& x){
    int help=0;
    day-=x;
    int licz=0;
    while (help!=1){
        if(czy_poprawna(day,month,year)){
            help=1;
        }else{
            licz=day+dniwmiesiacach[czy_przest(year)][month];
            day=licz;
            month--;
            if(month<1){
                month=12;
                year--;
            }
        }
    }
    return *this;
}

void data::print(){
    cout << this->day << "." << this->month << "." << this->year << endl;
}





