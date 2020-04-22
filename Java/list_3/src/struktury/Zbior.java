package struktury;

/**
 * Klasa abstrakcyjna Zbior, przechowująca pary
 */

public abstract class Zbior {

    /**
     * Metoda ma szukać pary z określonym kluczem
     *
     * @param k typu string
     * @return Para z określonym kluczem k
     */

    public abstract Para szukaj (String k) throws Exception;

    /**
     * Metoda ma wstawiać do zbioru nową parę
     *
     * @param p typu Para
     */

    public abstract void wstaw (Para p) throws Exception;

    /**
     * Metoda ma odszukać parę i zwrócić wartość związaną z kluczem
     *
     * @param k typu string
     * @return wartosc zwiazana z kluczem k
     */

    public abstract double czytaj (String k) throws Exception;

    /**
     * Metoda ma wstawić do zbioru nową albo zaktualizować parę
     *
     * @param p typu Para
     */

    public abstract void ustaw (Para p) throws Exception;

    /**
     * Metoda ma usunąć wszystkie pary ze zbioru
     */

    public abstract void czysc ();

    /**
     * Metoda ma podać ile par jest przechowywanych w zbiorze
     *
     * @return ilość par jest przechowywanych w zbiorze typu Int
     */

    public abstract int ile ();

}
