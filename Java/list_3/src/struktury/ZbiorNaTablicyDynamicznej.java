package struktury;

/**
 * Klasa dziedzicząca po ZbiorNaTablicy, implementująca zbiór na dynamicznej tablicy
 */

public class ZbiorNaTablicyDynamicznej extends ZbiorNaTablicy{

    /**
     * Konstruktor tworzący zbiór o początkowej wielkości 2
     */

    public ZbiorNaTablicyDynamicznej() throws Exception{
        super(2);
    }

    @Override
    public void wstaw(Para p) throws Exception {
        try{
            super.wstaw(p);
        }
        catch(Exception e){
            this.rozmiar *= 2;
            Para[] res = new Para[rozmiar];
            for (int i = 0; i < this.licznik; i++) {
                res[i] = this.tablica[i];
            }
            this.tablica = res;
            super.wstaw(p);
        }
    }

}
