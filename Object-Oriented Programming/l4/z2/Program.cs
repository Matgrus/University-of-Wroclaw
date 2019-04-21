using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L4Z2
{

    public class Primes : IEnumerator
    {
        private int number;

        private bool test(int n)
        {
            for (int i = 2; i < (int)Math.Sqrt(n)+1; i++)
            {
                if (n % i == 0)
                {
                    return false;
                }
            }
            return true;
        }

        public Primes()
        {
            number = 1;
        }

        public bool MoveNext()
        {
            number++;
            while (!test(number))
            {
                number++;
            } 
            return (number < int.MaxValue);
        }

        public void Reset()
        {
            number = 1;
        }

        object IEnumerator.Current
        {
            get
            {
                return number;
            }
        }
    }

    class PrimeCollection : IEnumerable
    {
        public IEnumerator GetEnumerator()
        {
            return new Primes();
        }
    }

class Program
    {
        static void Main(string[] args)
        {   
            PrimeCollection pc = new PrimeCollection();
            foreach (int p in pc)
                Console.WriteLine(p);
        }
    }
}
