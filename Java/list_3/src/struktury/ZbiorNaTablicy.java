package struktury;

/**
 * Klasa dziedzicząca po Zbior, implementująca zbiór na zwykłej tablicy
 */

public class ZbiorNaTablicy extends Zbior{

    int licznik = 0;
    int rozmiar;
    Para[] tablica;

    /**
     * Konstruktor tworzący zbiór o wielkości n
     *
     * @param n wielkość zbioru typu Int
     */

    public ZbiorNaTablicy(int n) throws Exception{
        if (n < 2) {
            throw new Exception("Rozmiar tablicy musi być większy niż 1");
        } else {
            this.rozmiar = n;
        }
        this.tablica = new Para[n];
    }

    @Override
    public Para szukaj(String s) throws Exception {
        for (int i = 0; i < licznik; i++) {
            if (tablica[i].klucz.equals(s)) {
                return tablica[i];
            }
        }
        throw new Exception("Nie znaleziono klucza " + s);
    }

    @Override
    public void wstaw(Para p) throws Exception {
        if (licznik >= rozmiar) {
            throw new Exception("Brak miejsca na wstawienie nowej pary");
        }
        try {
            if (szukaj(p.klucz).klucz.equals(p.klucz)) {
                System.out.println("Klucz " + p.klucz + " już istnieje");
            }
        }
        catch(Exception e){
            tablica[licznik] = p;
            licznik++;
        }
    }

    @Override
    public double czytaj(String k) throws Exception {
        try {
            return szukaj(k).get_val();
        }
        catch(Exception e){
            throw new Exception("Nie znaleziono klucza " + k);
        }
    }

    @Override
    public void ustaw(Para p) throws Exception {
        try {
            szukaj(p.klucz).set_val(p.get_val());
        }
        catch(Exception e){
            wstaw(p);
        }
    }

    @Override
    public void czysc() {
        for (int i = 0; i < rozmiar; i++) {
            tablica[i] = null;
        }
        licznik = 0;
    }

    @Override
    public int ile() {
        return licznik;
    }

}
