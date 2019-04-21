using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using L3Z4CLASS;
using L3Z4CLASS.Macierz;


namespace L3Z4
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Wektor w1: ");
            Wektor w1 = new Wektor(0, 1, 2, 3);
            w1.wypisz();
            Console.WriteLine();

            Console.Write("Wektor w2: ");
            Wektor w2 = new Wektor(4, 3, 2, 1);
            w2.wypisz();
            Console.WriteLine();

            Console.Write("w1 + w2 = ");
            Wektor w3 = w1 + w2;
            w3.wypisz();
            Console.WriteLine();

            Console.Write("w1 * 10 = ");
            Wektor w4 = w1 * 10;
            w4.wypisz();
            Console.WriteLine();

            Console.Write("Iloczyn skalarny w1 oraz w2 = ");
            float a = w1 % w2;
            Console.Write(a);
            Console.WriteLine();

            Console.WriteLine();

            Macierz m1 = new Macierz(w1, w2, w3, w4);
            Console.WriteLine("Macierz m1: ");
            m1.wypisz();
            Console.WriteLine();

            Macierz m2 = new Macierz(w4, w3, w2, w1);
            Console.WriteLine("Macierz m2: ");
            m2.wypisz();
            Console.WriteLine();

            Console.WriteLine("m1 + m2 = ");
            Macierz m3 = m1 + m2;
            m3.wypisz();

            Console.WriteLine("m1 * m2 = ");
            Macierz m4 = m1 * m2;
            m4.wypisz();

            Console.WriteLine("m1 * w1 = ");
            Macierz m5 = m2 * w1;
            m5.wypisz();


        }
    }
}
