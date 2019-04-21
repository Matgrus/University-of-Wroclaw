using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L2Z4
{
    class ListaLeniwa
    {
        protected List<int> l = new List<int>();
        public virtual int element(int x){
            if (x > l.Count){
                while (l.Count != x){
                    l.Add(l.Count + 1);
                }
            }
            return l[x - 1];
        }
        public int size(){
            return l.Count;
        }
    }

    class Pierwsze : ListaLeniwa
    {
        public bool is_prime(int x){
            if (x < 2){
                return false;
            }
            for (int i = 2; i < x; i++){
                if (x % i == 0){
                    return false;
                }
            }
            return true;
        }
        public override int element(int x)
        {
            if (x > l.Count){
                if (l.Count == 0){
                    l.Add(2);
                }
                for (int i = l.Count; i < x; i++){
                    int a = l[l.Count - 1] + 1;
                    while (!is_prime(a)){
                        a++;
                    }
                    l.Add(a);
                }
            }
            return l[x - 1];
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            ListaLeniwa lista1 = new ListaLeniwa();
            Console.Write("rozmiar pustej listy: "); Console.WriteLine(lista1.size());
            Console.Write("lista.element(40): "); Console.WriteLine(lista1.element(40));
            Console.Write("size: "); Console.WriteLine(lista1.size());
            Console.Write("lista.element(38): "); Console.WriteLine(lista1.element(38));
            Console.Write("size: "); Console.WriteLine(lista1.size());
            Console.Write("lista.element(40): "); Console.WriteLine(lista1.element(40));
            Console.Write("size: "); Console.WriteLine(lista1.size());

            Console.WriteLine();
            Console.WriteLine("Lista liczb pierwszych: ");
            Pierwsze lista2 = new Pierwsze();
            Console.Write("rozmiar pustej listy: "); Console.WriteLine(lista2.size());
            Console.Write("lista.element(10): "); Console.WriteLine(lista2.element(10));
            Console.Write("size: "); Console.WriteLine(lista2.size());
            Console.Write("lista.element(4): "); Console.WriteLine(lista2.element(4));
            Console.Write("size: "); Console.WriteLine(lista2.size());
        }
    }
}
