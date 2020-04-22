package geometria;

public class Punkt {

    private double x;
    private double y;

    public Punkt(double x, double y) {
        this.x = x;
        this.y = y;
    }

    double get_x() {
        return x;
    }

    double get_y() {
        return y;
    }

    void przesun(Wektor v) {
        this.x += v.dx;
        this.y += v.dy;
    }

    void obroc(Punkt p, double angle) {
        double res1 = Math.cos(Math.toRadians(angle)) * (this.x - p.x) - Math.sin(Math.toRadians(angle)) * (this.y - p.y) + p.x;
        double res2 = Math.sin(Math.toRadians(angle)) * (this.x - p.x) + Math.cos(Math.toRadians(angle)) * (this.y - p.y) + p.y;
        this.x = res1;
        this.y = res2;
    }

    void odbij(Prosta p) {
        try {
            Prosta prost = new Prosta(-p.b, p.a, p.b * this.x - p.a * this.y);
            Punkt przec = Prosta.punkt_przeciecia(p, prost);
            Wektor w = new Wektor(przec.x - this.x, przec.y - this.y);
            przesun(Wektor.wektor_zloz(w, w));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String to_string(){
            return "(" + x + " , " + y + ")";
        }
}

