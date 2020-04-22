package geometria;

public class Trojkat {
    private Punkt a;
    private Punkt b;
    private Punkt c;

    public Trojkat(Punkt a, Punkt b, Punkt c) throws Exception{
        double ab = Math.sqrt(Math.pow(b.get_x()-a.get_x(),2)+Math.pow(b.get_y()-a.get_y(),2));
        double ac = Math.sqrt(Math.pow(c.get_x()-a.get_x(),2)+Math.pow(c.get_y()-a.get_y(),2));
        double bc = Math.sqrt(Math.pow(c.get_x()-b.get_x(),2)+Math.pow(c.get_y()-b.get_y(),2));
        if(ab >= ac + bc || ac >= ab + bc || bc >= ab + ac){
            throw  new  Exception("Z tych punktów nie można utworzyć trójkąta");
        }
        this.a = a;
        this.b = b;
        this.c = c;
    }
    public void przesun(Wektor v){
        this.a.przesun(v);
        this.b.przesun(v);
        this.c.przesun(v);
    }
    public void obroc(Punkt p, double angle){
        this.a.obroc(p, angle);
        this.b.obroc(p, angle);
        this.c.obroc(p, angle);
    }
    public void odbij(Prosta p){
        this.a.odbij(p);
        this.b.odbij(p);
        this.c.odbij(p);
    }
    public String to_string(){
        return "/_\\ = " + this.a.to_string() + " , "+ this.b.to_string() +" , "+ this.c.to_string();
    }
}