typedef struct Ulamek
{
    int licznik, mianownik;
} Ulamek;

void skroc(Ulamek* a);
void wypisz(Ulamek* a);

Ulamek* dodaj(Ulamek* a, Ulamek* b);
Ulamek* odejmij(Ulamek* a, Ulamek* b);
Ulamek* pomnoz(Ulamek* a, Ulamek* b);
Ulamek* podziel(Ulamek* a, Ulamek* b);

void dodaj2(Ulamek* a, Ulamek* b);
void odejmij2(Ulamek* a, Ulamek* b);
void pomnoz2(Ulamek* a, Ulamek* b);
void podziel2(Ulamek* a, Ulamek* b);
