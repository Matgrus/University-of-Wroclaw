using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L3Z4CLASS
{
    public class Wektor
    {
        public float[] wspolrzedne;
        public int dlugosc;
        public Wektor(float[] wspolrzedne, bool a)
        {
            this.wspolrzedne = wspolrzedne;
            dlugosc = wspolrzedne.Length;
        }
        public Wektor(params float[] wspolrzedne)
        {
            this.wspolrzedne = wspolrzedne;
            dlugosc = wspolrzedne.Length;
        }
        public void wypisz()
        {
            Console.Write("[");
            foreach (float x in wspolrzedne) Console.Write(x + " ");
            Console.Write("]");
        }
        public static Wektor operator +(Wektor w1, Wektor w2)
        {
            if (w1.dlugosc != w2.dlugosc)
            {
                Console.WriteLine("Wektory musza byc tej samej dlugosci!");
                return null;
            }
            float[] res = new float[w1.dlugosc];
            for (int i = 0; i < w1.dlugosc; i++)
            {
                res[i] = w1.wspolrzedne[i] + w2.wspolrzedne[i];
            }
            return new Wektor(res);
        }
        public static float operator %(Wektor w1, Wektor w2)
        {
            if (w1.dlugosc != w2.dlugosc)
            {
                Console.WriteLine("Wektory musza byc tej samej dlugosci!");
                return 0;
            }
            float res = 0;
            for (int i = 0; i < w1.dlugosc; i++)
            {
                res += w1.wspolrzedne[i] * w2.wspolrzedne[i];
            }
            return res;
        }
        public static Wektor operator *(Wektor w1, float num)
        {
            float[] res = new float[w1.dlugosc];
            for (int i = 0; i < w1.dlugosc; i++)
            {
                res[i] = w1.wspolrzedne[i] * num;
            }
            return new Wektor(res);
        }
    }
    namespace Macierz
    {

        public class Macierz : Wektor
        {
            Wektor[] Wektory = new Wektor[0];
            public int rozmiar = 0;
            public Macierz(Wektor[] tablica_wektorow, bool a)
            {
                Wektory = tablica_wektorow;
                rozmiar = tablica_wektorow.Length;
            }
            public Macierz(params Wektor[] wektory)
            {
                Array.Resize(ref Wektory, wektory.Length);
                for (int i = 0; i < wektory.Length; i++)
                {
                    if (wektory[0].dlugosc != wektory[i].dlugosc)
                    {
                        Console.WriteLine("Wektory w macierzy musza byc tej samej dlugosci!");
                        break;
                    }
                    Wektory[i] = new Wektor(wektory[i].wspolrzedne);
                    rozmiar++;
                }
            }
            public void wypisz()
            {
                foreach (Wektor x in Wektory)
                {
                    x.wypisz();
                    Console.WriteLine();
                }
            }
            public static Macierz operator +(Macierz x1, Macierz x2)
            {
                if (x1.rozmiar != x2.rozmiar || x1.Wektory[0].dlugosc != x2.Wektory[0].dlugosc)
                {
                    Console.WriteLine("Macierze musza byc tych samych wymiarow!");
                    return null;
                }
                Wektor[] res = new Wektor[x1.rozmiar];
                for (int i = 0; i < x1.rozmiar; i++)
                {
                    float[] w = new float[x1.Wektory[0].dlugosc];
                    for (int j = 0; j < x1.Wektory[0].dlugosc; j++)
                    {
                        w[j] = x1.Wektory[i].wspolrzedne[j] + x2.Wektory[i].wspolrzedne[j];
                    }
                    res[i] = new Wektor(w);
                }
                return new Macierz(res);
            }
            public static Macierz operator *(Macierz x1, Macierz x2)
            {
                if (x1.Wektory[0].dlugosc != x2.rozmiar)
                {
                    Console.WriteLine("Macierze musza miec ta sama dlugosc!");
                    return null;
                }
                Macierz res = new Macierz(new Wektor[x1.Wektory[0].dlugosc], true);
                for (int i = 0; i < x1.Wektory[0].dlugosc; i++)
                {
                    res.Wektory[i] = new Wektor(new float[x2.Wektory[0].dlugosc], true);
                }
                for (int i = 0; i < x2.Wektory[0].dlugosc; i++)
                {
                    for (int j = 0; j < x1.rozmiar; j++)
                    {
                        float suma = 0;
                        for (int k = 0; k < x1.Wektory[0].dlugosc; k++)
                        {
                            suma += x1.Wektory[j].wspolrzedne[k] * x2.Wektory[k].wspolrzedne[i];
                        }
                        res.Wektory[j].wspolrzedne[i] = suma;
                    }
                }
                return res;
            }
            public static Macierz operator *(Macierz x, Wektor w)
            {
                if (x.Wektory[0].dlugosc != w.dlugosc)
                {
                    Console.WriteLine("wektor musi byc tej samej dlugosci co wektory macierzy!");
                    return null;
                }
                Macierz res = new Macierz(new Wektor[w.dlugosc], true);
                for(int i = 0; i < w.dlugosc; i++)
                {
                    res.Wektory[i] = new Wektor(w.wspolrzedne[i]);
                }
                res.wypisz();
                x.wypisz();
                Macierz wyn = x * res;
                return wyn;
            }
        }
    }
}
