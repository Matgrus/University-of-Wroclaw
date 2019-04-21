using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L2Z1
{
    public class IntStream
    {
        public int poprzednia;
        public IntStream(){
            poprzednia = -1;
        }
        public virtual int next(){
            poprzednia++;
            return poprzednia;
        }
        public virtual bool eos(){
            if (poprzednia == int.MaxValue){
                return true;
            }
            else{
                return false;
            }
        }
        public virtual void reset(){
            poprzednia = -1;
        }
    }

    class PrimeStream : IntStream
    {
        bool a;
        public bool is_prime(int x){
            if (x < 2){
                return false;
            }
            for(int i = 2; i < x; i++){
                if (x % i == 0){
                    return false;
                }
            }
            return true;
        }
        public override int next(){
            poprzednia++;
            while (!is_prime(poprzednia)){
                if (poprzednia == int.MaxValue){
                    a = true;
                    return -1;
                }
                poprzednia++;
            }
            return poprzednia;
        }
        public override bool eos(){
            return a;
        }
        public override void reset(){
            poprzednia = -1;
            a = false;
        }
    }

    public class RandomStream : IntStream
    {
        Random a = new Random();
        public override int next(){
            return a.Next(0, int.MaxValue);
        }
        public override bool eos(){
            return false;
        }
    }

    public class RandomWordStream
    {
        PrimeStream ps;
        public RandomWordStream(){
            ps = new PrimeStream();
        }
        Random a = new Random();
        public char[] next(){
            int i = ps.next();
            char[] str = new char[i];
            while (i > 0){
                str[i-1] = (char)('a' + a.Next(0, 26));
                i--;
            }
            return str;
        }
        public bool eos(){
            return ps.eos();
        }
        public void reset(){
            ps.reset();
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("IntStream: ");
            IntStream ints = new IntStream();
            for (int i = 0; i < 10; i++){
                Console.WriteLine(ints.next());
            }

            Console.WriteLine();
            Console.WriteLine("PrimeStream: ");
            PrimeStream ps = new PrimeStream();
            for (int i = 0; i < 10; i++){
                Console.WriteLine(ps.next());
            }

            Console.WriteLine();
            Console.WriteLine("RandomStream: ");
            RandomStream rs = new RandomStream();
            for (int i = 0; i < 10; i++){
                Console.WriteLine(rs.next());
            }

            Console.WriteLine();
            Console.WriteLine("RandomWordStream: ");
            RandomWordStream rws = new RandomWordStream();
            for (int i = 0; i < 10; i++){
                Console.WriteLine(rws.next());
            }
            rws.reset();
            for (int i = 0; i < 10; i++){
                Console.WriteLine(rws.next());
            }
        }
    }
}
