package struktury;

/**
 * Klasa Para służy do przechowywania par (klucz, wartość)
 */

public class Para {

    final String klucz;
    private double wartosc;

    /**
     * Konstruktor pary
     *
     * @param klucz typu string
     * @param wartosc typu double
     */

    public Para(String klucz, Double wartosc) throws Exception{
        if (klucz == null || klucz.equals("")){
            throw new Exception("Klucz nie może być nullem, ani łańcuchem pustym");
        }
        this.klucz = klucz;
        this.wartosc = wartosc;
    }

    /**
     * Getter wartosci
     *
     * @return wartosc pary
     */

    public double get_val() {
        return wartosc;
    }

    /**
     * Setter wartosci
     *
     * @param new_val nowa wartosc typu string
     */

    public void set_val(double new_val) {
        this.wartosc = new_val;
    }

    /**
     * Metoda konwertująca parę do stringa
     *
     * @return "klucz: ..., wartosc: ..."
     */

    public String toString() {
        return "klucz: " + klucz + ", wartość: " + wartosc;
    }

    /**
     * Metoda porównująca dwie pary na podstawie klucza
     *
     * @param p typu Para
     * @return wartosc typu boolean
     */

    public boolean equals(Para p) {
        return this.klucz.equals(p.klucz);
    }

}
