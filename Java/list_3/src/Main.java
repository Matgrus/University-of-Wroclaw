import struktury.*;

public class Main {
    public static void main(String[] args) throws Exception {


        ZbiorNaTablicy test = new ZbiorNaTablicy(5);
        Para a = new Para("a", 1d);
        Para b = new Para("b", 10d);
        Para c = new Para("c", 100d);
        Para d = new Para("d", 1000d);
        Para e = new Para("e", 10000d);
        Para f = new Para("f", 100000d);
        test.wstaw(a);
        test.wstaw(b);
        test.wstaw(c);
        test.wstaw(d);

        //testy


        c.set_val(101d);
        System.out.println(c.get_val());
        System.out.println(c);

        System.out.println(c.equals(d));
        System.out.println(c.equals(c));
        Para c2 = new Para("c", 200d);
        System.out.println(c.equals(c2));

        // szukanie

        System.out.println(test.szukaj("c"));
        //test.szukaj("g");

        // wstawianie

        test.wstaw(c);
        test.wstaw(e);
        //test.wstaw(f);
        //test.ustaw(f);

        // czytanie

        System.out.println(test.czytaj("a"));
        //System.out.println(test.czytaj("g"));

        System.out.println(test.ile());

        // czyszczenie

        test.czysc();
        System.out.println(test.ile());

        // ustawianie

        test.ustaw(c);
        System.out.println(test.czytaj("c"));

        test.ustaw(c2);
        System.out.println(test.czytaj("c"));

        // tablica z rozmiarem < 2

        //ZbiorNaTablicy t2 = new ZbiorNaTablicy(0);

        // para ze zlym kluczem

        //Para p1 = new Para("", 6d);
        //Para p2 = new Para(null, 6d);

        // TABLICA DYNAMICZNA

        ZbiorNaTablicyDynamicznej test2 = new ZbiorNaTablicyDynamicznej();
        System.out.println(test2.ile());

        test2.wstaw(a);

        System.out.println(test2.ile());

        test2.wstaw(b);

        System.out.println(test2.ile());

        test2.wstaw(c);

        System.out.println(test2.ile());

        test2.wstaw(c2);

        System.out.println(test2.ile());

    }
}
