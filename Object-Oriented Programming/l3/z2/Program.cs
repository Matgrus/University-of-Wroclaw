using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using L3Z2CLASS;

namespace L3Z2
{
    class Program
    {
        static void Main(string[] args)
        {
            var x = new Slownik<int, string>();

            x.dodaj(1, "jeden");
            x.dodaj(2, "dwa");
            x.dodaj(3, "trzy");
            x.wypisz();

            x.usun(2);
            x.wypisz();

            x.wyszukaj(3);
        }
    }
}
