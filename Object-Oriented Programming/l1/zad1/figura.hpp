enum typfig {trojkat, kolo, kwadrat};

typedef struct Figura{
    enum typfig typ;
    float ax, ay, bx, by, cx, cy, r;
} Figura;

float pole(Figura *f);
void przesun(Figura *f, float x, float y);
float sumapol(Figura *f, int size);

Figura Trojkat(float ax, float ay, float bx, float by, float cx, float cy);
Figura Kolo(float ax, float ay, float r);
Figura Kwadrat(float ax, float ay, float bx, float by);
