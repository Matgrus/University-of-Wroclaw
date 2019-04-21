import java.util.*;

public class Zmienna implements Wyrazenie
{
	String s;
	Hashtable<String, Integer> tree;
	
	public Zmienna(String s, Hashtable<String, Integer> tree){
		this.s = s;
		this.tree = tree;
	}
	
	public int Oblicz(){
		return tree.get(s);
	}
	public String toString(){
		return s;
	}
}