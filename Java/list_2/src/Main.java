import geometria.*;

public class Main {
    public static void main(String[] args) {

        try{
            Punkt p1 = new Punkt(0, 1);
            Punkt p2 = new Punkt(-2, -1);
            Punkt p3 = new Punkt(2, 3);
            Punkt p4 = new Punkt(0, 4);

            System.out.println(p1.to_string());
            System.out.println(p2.to_string());
            System.out.println(p3.to_string());
            System.out.println(p4.to_string());

            Odcinek o1 = new Odcinek(p1, p3);
            System.out.println(o1.to_string());

            //Odcinek odc_test = new Odcinek(p2, p2);

            Trojkat t1 = new Trojkat(p1, p3, p4);
            System.out.println(t1.to_string());

            //Trojkat troj_test = new Trojkat(p1, p2, p3);

            Wektor w1 = new Wektor(-3, 1);
            System.out.println(w1.to_string());

            Prosta pp1 = new Prosta(-1, 1, -3);
            System.out.println(pp1.to_string());

            //Prosta prost_test = new Prosta(0, 0, 5);

            Trojkat t2 = new Trojkat(p1, p3, p4);
            System.out.println(t2.to_string());

            t2.przesun(w1);
            System.out.println(t2.to_string());

            t2.odbij(pp1);
            System.out.println(t2.to_string());

            t2.obroc(new Punkt(0, 0), 360);
            System.out.println(t2.to_string());

            Wektor w2 = new Wektor(2, -1);
            Wektor w3 = new Wektor(-6, 3);
            Wektor w4 = Wektor.wektor_zloz(w2, w3);
            System.out.println(w4.to_string());

            Prosta pp2 = new Prosta(1, 2, 3);
            Prosta pp3 = Prosta.przesun(w4, pp2);
            System.out.println(pp3.to_string());

            System.out.println(Prosta.proste_rownolegle(pp2, pp3));

            System.out.println(Prosta.proste_prostopadle(pp1, pp3));

            System.out.println(Prosta.punkt_przeciecia(pp1, pp3).to_string());

        }catch(Exception e){
            e.printStackTrace();
        }

    }
}
