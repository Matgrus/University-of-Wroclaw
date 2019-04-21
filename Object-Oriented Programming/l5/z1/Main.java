import java.util.*;

public class Main
{
    public static void main(String[] args){
        
        Kolekcja<String, Integer > test = new Kolekcja<>();
        test.ins("a", 3);
        test.ins("b", 4);
        test.ins("c", 1);
        test.ins("d", 20);
        test.ins("e", -1);
        test.print();
        test.del();
        System.out.println("===============");
        test.print();

        System.out.println();
        
        ArrayList<Stopnie_wojskowe> stopnie = new ArrayList<Stopnie_wojskowe>();
        stopnie.add(new General());
        stopnie.add(new Kapitan());
        stopnie.add(new Kapral());
        stopnie.add(new Szeregowy());
        Collections.sort(stopnie);
        for(Stopnie_wojskowe x : stopnie){
            System.out.println(x);
        }
    }
}