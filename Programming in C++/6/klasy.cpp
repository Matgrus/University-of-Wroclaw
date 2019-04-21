
#include "klasy.hpp"

#define M_E 2.71828182845904523536
#include <cmath>
#define M_PI 3.14159265358979323846


double bezwgledna::oblicz(){
    return fabs(a->oblicz());
}

bezwgledna::bezwgledna(wyrazenie *a){
    this->a=a;
}

std::string bezwgledna::opis(){
    return "|" + a->opis() + "|";
}

double cosinus::oblicz() {
    return cos(a->oblicz());
}

cosinus::cosinus(wyrazenie *a){
    this->a=a;
}

std::string cosinus::opis(){
    return "cos(" + a->opis() + ")";
}

double dodaj::oblicz(){
    return a->oblicz()+b->oblicz();
}

std::string dodaj::opis(){
    return "(" + a->opis() + " + " + b->opis() + ")";
}

dodaj::dodaj(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
}

double dziel::oblicz(){
    return a->oblicz()/b->oblicz();
}

dziel::dziel(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
    if(b->oblicz()==0){
        throw std::invalid_argument("Dzielenie przez 0");
    }
}

std::string dziel::opis(){
    return "(" + a->opis() + " / " + b->opis() + ")";
}

double e::oblicz() {
    return M_E;
}

std::string e::opis() {
    return "e";
}

double exponent::oblicz() {
    return exp(a->oblicz());
}
exponent::exponent(wyrazenie *a){
    this->a=a;
}

std::string exponent::opis() {
    return "exp(" + a->opis()+")";
}

double fi::oblicz() {
    return (sqrt(5)+1)/2 ;
}

std::string fi::opis() {
    return "fi";
}

double liczba::oblicz(){
    return value;
}

liczba::liczba(int val): value(val){}

std::string liczba::opis(){
    return std::to_string(value);
}

double ln::oblicz(){
    return log(a->oblicz());
}

ln::ln(wyrazenie *a){
    this->a = a;
    if(a->oblicz()==0){
            throw std::invalid_argument("Nie moze byc 0");
    }
}

std::string ln::opis(){
    return "ln("+a->opis()+")";
}

double logarytm::oblicz() {
    return log2(b->oblicz())/log2(a->oblicz());
}

logarytm::logarytm(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
}

std::string logarytm::opis() {
    return "log " + a->opis() + " z (" +  b->opis()+")";
}

double mnoz::oblicz() {
    return a->oblicz()*b->oblicz();
}

mnoz::mnoz(wyrazenie *a, wyrazenie *b) {
    this->a=a;
    this->b=b;
}

std::string mnoz::opis() {
    return "(" + a->opis() + " * " + b->opis() + ")";
}

double modulo::oblicz(){
    return fmod(a->oblicz(), b->oblicz());
}

modulo::modulo(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
    if(b->oblicz()==0){
        throw std::invalid_argument("Dzielenie przez 0");
    }
}

std::string modulo::opis(){
    return a->opis() + "mod" + b->opis();
}

double odejmij::oblicz(){
    return a->oblicz()-b->oblicz();
}
odejmij::odejmij(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
}

std::string odejmij::opis(){
    return "(" + a->opis() + " - " + b->opis() + ")";
}

double odwrot::oblicz(){
    return pow(a->oblicz(), -1);
}

odwrot::odwrot(wyrazenie *a){
    this->a=a;
    if(a->oblicz()==0){
        throw std::invalid_argument("Dzielenie przez 0");
    }
}

std::string odwrot::opis(){
    return a->opis() + "^-1";
}

std::string operator1arg::opis(){
    return std::to_string(oblicz());
}

std::string operator2arg::opis() {
    return std::to_string(oblicz());
}

double pi::oblicz(){
    return M_PI;
}

std::string pi::opis(){
    return "pi";
}

double potega::oblicz(){
    return pow(a->oblicz(),b->oblicz());
}

potega::potega(wyrazenie *a, wyrazenie *b){
    this->a=a;
    this->b=b;
}

std::string potega::opis(){
    return a->opis() + "^" + b->opis();
}

double przeciw::oblicz(){
    return (-1)*a->oblicz();
}

przeciw::przeciw(wyrazenie *a){
    this->a=a;
}

std::string przeciw::opis(){
    return "(-1)*" + a->opis();
}

double sinus::oblicz() {
    return sin(a->oblicz());
}

sinus::sinus(wyrazenie *a){
    this->a=a;
}

std::string sinus::opis() {
    return "sin(" + a->opis() + ")";
}

std::string stala::opis(){
    return std::to_string(oblicz());
}

double zmienna::oblicz() {
    for(int i=0; i<vars_tab.size(); i++){
        if(vars_tab[i].first==value){
            return vars_tab[i].second;
        }
    }
}

void zmienna::new_var(std::string x, double val){
    for(int i=0; i<vars_tab.size(); i++){
        if(vars_tab[i].first == x){
            throw std::invalid_argument("Taka zmienna juz istnieje");
        }
    }
    vars_tab.emplace_back(std::make_pair(x, val));
}

void zmienna::set_value(double val){
    for(int i=0; i<vars_tab.size(); i++){
        if(vars_tab[i].first == value){
            vars_tab[i].second = val;
        }
    }
}

zmienna::zmienna(const std::string &value): value(value){
    new_var(value,0);
}

std::string zmienna::opis(){
    return value;
}
