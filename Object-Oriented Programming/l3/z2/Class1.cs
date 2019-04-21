using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L3Z2CLASS
{
    public class Slownik<K,V> where K : IComparable<K>
    {
        Slownik<K, V> next;
        protected K key;
        protected V value;

        public Slownik()
        {
            next = null;
            key = default(K);
            value = default(V);
        }
        public void wypisz()
        {
            if (next != null)
            {
                Console.WriteLine("{0} {1}", key, value);
                next.wypisz();
            }
            else
            {
                Console.WriteLine("{0} {1}", key, value);
            }
        }
        public void dodaj(K key,V value)
        {
            if (next != null)
            {
                next.dodaj(key, value);
            }
            else
            {
                next = new Slownik<K, V>();
                next.key = key;
                next.value = value;
            }
        }
        public V wyszukaj(K key)
        {
            Slownik<K, V> current = this;
            while (key.CompareTo(current.key) != 0)
            {
                current = current.next;
                if (current == null)
                {
                    return default(V);
                }
            }
            Console.WriteLine("{0} ", current.key);
            return current.value;
        }
        public void usun(K key)
        {
            if (key.CompareTo(next.key) == 0)
            {
                Console.WriteLine("usunieto {0}", next.key);
                next = next.next;
            }
            else
            {
                if (next != null)
                {
                    next.usun(key);
                }
            }
        }
    }
}
