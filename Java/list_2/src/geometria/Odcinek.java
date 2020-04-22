package geometria;

public class Odcinek {
    private Punkt a;
    private Punkt b;

    public Odcinek(Punkt a, Punkt b)throws Exception{
        if(a.get_x() == b.get_x() && a.get_y() == b.get_y()){
            throw new Exception("Nie można utworzyć odcinka z dwóch jednakowych punktów");
        }else {
            this.a = a;
            this.b = b;
        }
    }

    public void przesun(Wektor v){
        this.a.przesun(v);
        this.b.przesun(v);
    }
    public void obroc(Punkt p, double angle){
        this.a.obroc(p, angle);
        this.b.obroc(p, angle);
    }
    public void odbij(Prosta p){
        this.a.odbij(p);
        this.b.odbij(p);
    }

    public String to_string() {
        return "| " + this.a.to_string() + "---" + this.b.to_string() + " |";
    }
}