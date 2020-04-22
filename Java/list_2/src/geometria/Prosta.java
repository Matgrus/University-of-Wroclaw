package geometria;

public class Prosta {
    final double a;
    final double b;
    private final double c;

    public Prosta(double a, double b, double c) throws Exception {
        if (a == 0.0 && b == 0.0) throw new Exception("Nie można utworzyć prostej");
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public static Prosta przesun(Wektor v, Prosta p) throws Exception{
        try {
            return new Prosta(p.a, p.b, (p.c - v.dy - p.a * v.dx) / p.b);
        } catch (Exception e) {
            throw e;
        }
    }

    public static boolean proste_rownolegle(Prosta p, Prosta k) {
        return p.a * k.b - k.a * p.b == 0;
    }

    public static boolean proste_prostopadle(Prosta p, Prosta k) {
        return p.a * k.a + p.b * k.b == 0;
    }

    public static Punkt punkt_przeciecia(Prosta p, Prosta k) throws Exception {
        if (proste_rownolegle(p, k)){
            throw new Exception("Proste nie mogą być równoległe");
        }
        double x = (-p.c * k.b - -k.c * p.b) / (p.a * k.b - k.a * p.b);
        double y = (p.a * -k.c - k.a * -p.c) / (p.a * k.b - k.a * p.b);
        return new Punkt(x, y);
    }

    public String to_string() {
        return this.a + "x + " + this.b + "y + " + this.c + " = 0";
    }
}

