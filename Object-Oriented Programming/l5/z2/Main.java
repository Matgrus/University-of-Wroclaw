import java.util.Hashtable;

public class Main
{
	public static void main(String[] args)
	{
		Hashtable<String, Integer> tree = new Hashtable<String, Integer>();
		tree.put("x",2);
		System.out.println("x = " + tree.get("x"));
		tree.put("y",3);
		System.out.println("y = " + tree.get("y"));

		Wyrazenie w1 = new Dodaj(new Zmienna("x",tree), new Zmienna("y", tree));
		System.out.println(w1.toString() + " = " + w1.Oblicz());
		
		Wyrazenie w2 = new Odejmij(new Zmienna("x",tree), new Zmienna("y", tree));
		System.out.println(w2.toString() + " = " + w2.Oblicz());
		
		Wyrazenie w3 = new Pomnoz(new Zmienna("x",tree), new Zmienna("y", tree));
		System.out.println(w3.toString() + " = " + w3.Oblicz());
		
		Wyrazenie w4 = new Podziel(new Zmienna("x",tree), new Zmienna("y", tree));
		System.out.println(w4.toString() + " = " + w4.Oblicz());
	}
}