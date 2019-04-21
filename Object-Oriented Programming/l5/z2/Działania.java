class Dodaj implements Wyrazenie 
{
	Wyrazenie x;
	Wyrazenie y;
	
	public Dodaj(Wyrazenie x, Wyrazenie y){
		this.x = x;
		this.y = y;
	}
	public int Oblicz(){
		return x.Oblicz() + y.Oblicz();
	}
	public String toString(){
		return "(" + x + " + " + y + ")";
	}	
}

class Odejmij implements Wyrazenie 
{
	Wyrazenie x;
	Wyrazenie y;
	
	public Odejmij(Wyrazenie x, Wyrazenie y){
		this.x = x;
		this.y = y;
	}
	public int Oblicz(){
		return x.Oblicz() - y.Oblicz();
	}
	public String toString(){
		return "(" + x + " - " + y + ")";
	}	
}

class Pomnoz implements Wyrazenie 
{
	Wyrazenie x;
	Wyrazenie y;
	
	public Pomnoz(Wyrazenie x, Wyrazenie y){
		this.x = x;
		this.y = y;
	}
	public int Oblicz(){
		return x.Oblicz() * y.Oblicz();
	}
	public String toString(){
		return "(" + x + " * " + y + ")";
	}	
}

class Podziel implements Wyrazenie 
{
	Wyrazenie x;
	Wyrazenie y;
	
	public Podziel(Wyrazenie x, Wyrazenie y){
		this.x = x;
		this.y = y;
	}
	public int Oblicz(){
		return x.Oblicz() / y.Oblicz();
	}
	public String toString(){
		return "(" + x + " / " + y + ")";
	}	
}