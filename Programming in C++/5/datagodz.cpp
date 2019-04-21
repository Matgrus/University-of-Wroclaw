#include "datagodz.hpp"

using namespace std;


int datagodz::return_hour(){
    return hour;
}
int datagodz::return_minute(){
    return minute;
}
int datagodz::return_second(){
    return second;
}

datagodz::datagodz(int d, int mo, int y, int h, int mi, int s){
    day=d;
    month=mo;
    year=y;
    hour=h;
    minute=mi;
    second=s;
}

datagodz::datagodz(){
   time_t now = time(0);
   tm *ltm = localtime(&now);
   year= 1900 + ltm->tm_year;
   month= 1 + ltm->tm_mon;
   day= ltm->tm_mday;
   hour= ltm->tm_hour;
   minute= ltm->tm_min;
   second= 1 + ltm->tm_sec;
}

datagodz& datagodz::operator++(int){
    if(second+1<60){
        second++;
        return *this;
    }else if(minute+1<60){
        minute++;
        second=0;
        return *this;
        /*
    }else{
        hour++;
        minute=0;
        second=0;
        return *this;
    }
}
*/
    }else if(hour<23){
        hour++;
        minute=0;
        second=0;
        return *this;
    }else if(czy_poprawna(day+1,month,year)){
        hour=0;
        minute=0;
        second=0;
        day++;
        return *this;
    }else if(czy_poprawna(day,month+1,year)){
        hour=0;
        minute=0;
        second=0;
        day=1;
        month++;
        return *this;
    }else{
        hour=0;
        minute=0;
        second=0;
        day=1;
        month=1;
        year++;
        return *this;
    }
}

datagodz& datagodz::operator--(int){
    if(second-1>=0){
        second--;
        return *this;
    }else if(minute-1>=0){
        minute--;
        second=59;
        return *this;
        /*
    }else{
        hour--;
        minute=59;
        second=59;
        return *this;
    }
}
*/
    }else if(hour>=24){
        hour--;
        minute=59;
        second=59;
        return *this;
    }else if(czy_poprawna(day-1,month,year)){
        hour=23;
        minute=59;
        second=59;
        day--;
        return *this;
    }else if(czy_poprawna(day,month-1,year)){
        hour=23;
        minute=59;
        second=59;
        day=dniwmiesiacach[czy_przest(year)][month-1];
        month--;
        return *this;
    }else{
        hour=23;
        minute=59;
        second=59;
        day=31;
        month=12;
        year--;
        return *this;
    }
}

void datagodz::print(){
    cout << this->day << "." << this->month << "." << this->year
         << " " << this->hour << ":" << this->minute << ":" << this->second << endl;
}

bool datagodz::operator==(const datagodz& x){
    if(this->year==x.year && this->month==x.month && this->day==x.day
       && this->hour==x.hour && this->minute==x.minute && this->second==x.second){
        return true;
    }else{
        return false;
    }
}

bool datagodz::operator<(const datagodz& x){
    /*
    if(this->year<x.year){
        return true;
    }else if(this->month<x.month){
        return true;
    }else if(this->day<x.day){
        return true;
        */
    if(ile_dni(data(this->day,this->month,this->year))<ile_dni(data(x.day,x.month,x.year))){
        return true;
    }else if(this->hour<x.hour){
        return true;
    }else if(this->minute<x.minute){
        return true;
    }else if(this->second<x.second){
        return true;
    }else{
        return false;
    }
}

datagodz& datagodz::operator+=(const int& x){
    int help=0;
    second+=x;
    int licz=0;
    while(help!=1){
        if(second<60 && minute<60 && hour<24){
            help=1;
        }else{
            licz=second-60;
            second=licz;
            minute++;
            if(minute>59){
                minute=0;
                hour++;
            }
        }
    }
    return *this;
}

datagodz& datagodz::operator-=(const int& x){
    int help=0;
    second-=x;
    int licz=0;
    while(help!=1){
        if(second>=0 && minute>=0 && hour>=0){
            help=1;
        }else{
            licz=second+60;
            second=licz;
            minute--;
            if(minute<0){
                minute=59;
                hour--;
            }
        }
    }
    return *this;
}

int datagodz::operator-(const datagodz& x){
    int w1=ile_dni(data(x.day,x.month,x.year))*3600*24;
    int w2=ile_dni(data(this->day,this->month,this->year))*3600*24;
    w1+=x.second+60*x.minute+3600*x.hour;
    w2+=this->second+60*this->minute+3600*this->hour;
    return abs(w1-w2);
}





