package geometria;

public class Wektor {
    final double dx;
    final double dy;

    public Wektor(double x, double y){
        this.dx = x;
        this.dy = y;
    }

    public static Wektor wektor_zloz(Wektor v1, Wektor v2){
        return new Wektor(v1.dx + v2.dx, v1.dy + v2.dy);
    }

    public String to_string(){
        return "[" + this.dx + " , " + this.dy + "]";
    }
}