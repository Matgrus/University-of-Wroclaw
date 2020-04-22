import java.io.IOException;
import java.util.*;
import java.text.SimpleDateFormat;
import java.util.logging.*;
import wyjatki.*;

public class Main {
    public static void main(String args[]) throws IOException, Exception_bledne_dane {

        /**
         * utworzenie dziennika
         */
        Logger logger = Logger.getLogger(Main.class.getName());
        /**
         * utworzenie rejestratora komunikatow zwiazanego z plikiem
         */
        Handler handler = new FileHandler("ustawienie.log", true);
        /**
         * utworzenie formatera
         */
        handler.setFormatter(new SimpleFormatter());
        /**
         * dodanie rejestratora do dziennika
         */
        logger.addHandler(handler);
        /**
         * poczatek logowania komunikatow
         */
        logger.entering(Main.class.getName(), "main");

        /**
         * czas rozpoczecia gry
         */
        Date start_date = new Date();
        SimpleDateFormat date_format = new SimpleDateFormat("hh:mm:ss");
        System.out.println(date_format.format(start_date));
        logger.log(Level.INFO, "Czas rozpoczęcia gry: " + date_format.format(start_date));

        Scanner in = new Scanner(System.in);

        /**
         * wczytanie imienia uzytkownika
         */
        System.out.println("Podaj swoje imie ");
        String imie = in.next();
        logger.log(Level.INFO, "Imie gracza: " + imie);

        /**
         * wczytanie ilosci liczb
         */
        System.out.println("Podaj ilość liczb");
        int n = in.nextInt();
        if(n > 9 || n < 3){
            throw new Exception_liczba_zakres("Wybrano liczbe spoza zakresu");
        }
        logger.log(Level.INFO, "Wybrana ilosc liczb to: " + n);

        /**
         * tablica zawierajaca permutacje
         */
        Integer[] perm = new Integer[n];

        /**
         * tablica liczb wybranych przez uzytkownika
         */
        int[] user_perm = new int[n];

        for(int i=0; i<n;i++){
            perm[i] = i+1;
        }

        /**
         * licznik rund
         */
        int runda = 1;

        /**
         * limit blednych prob
         */
        int limit = 1;
        for(int i=1;i<n+1;i++){
            limit*=i;
        }

        SimpleDateFormat round_format = new SimpleDateFormat("hh:mm:ss:SSS");
        //List<SimpleDateFormat> rounds_duration = new ArrayList<>();

        //List<String> user_answers = new ArrayList<>();

        /**
         * odczytywanie danych od uzytkownika
         */
        String c;
        while(true){


            /**
             * sprawdzanie czy nie osiagnelismy limitu blednych prob
             */
            assert(runda != limit + 1): "Wykonano zbyt wiele prób";


            /**
             * poczatek rundy
             */
            Date round_start = new Date();
            //System.out.println("Poczatek: " + round_format.format(round_start));

            System.out.println("Runda: " + runda);

            /**
             * mieszamy elementy listy
             */
            Collections.shuffle(Arrays.asList(perm));

            c = in.next();

            /**
             * sprawdzamy czy uzytkownik zakonczyl runde
             * jesli nie zakonczyl to sprawdzamy czy wprowadzil poprawne dane
             * jesli tak, to sprawdzamy czy podal dobra odpowiedz
             * jesli nie podal dobrej odpowiedzi to pokazujemy mu przkladowy blad
             */
            if(c.equals("q")){
                logger.log(Level.INFO, "Uzytkownik zakonczyl gre");
                break;
            }else if(c.length() == n){
                String[] inp = c.split("");
                for(int i=0;i<n;i++){
                    user_perm[i] = Integer.parseInt(inp[i]);
                }

                /**
                 * sprawdzamy czy uzytkownik podal rozne cyfry
                 */
                for (int i = 0; i < user_perm.length; i++) {
                    for (int j = i + 1 ; j < user_perm.length; j++) {
                        if (user_perm[i] == (user_perm[j])) {
                            throw new Exception_rozne_cyfry("Nie wprowadzono roznych cyfr");
                        }
                    }
                }

                /**
                 * sprawdzamy czy uzytkownik podal cyfry z danego zakresu
                 */
                for (int i = 0; i < user_perm.length; i++) {
                    if(user_perm[i] < 1 || user_perm[i] > n){
                        throw new Exception_liczba_zakres("Podano cyfre spoza zakresu");
                    }
                }

                System.out.println("Podano: " + Arrays.toString(user_perm));
                //System.out.println("Odpowiedź to: " + Arrays.asList(perm));
                logger.log(Level.INFO, "Propozycja gracza w rundzie nr " + runda + " to: " + Arrays.toString(user_perm));

                //user_answers.add(Arrays.toString(user_perm));

                /**
                 * przechowujemy wszystkie bledne pozycje w odpowiedzi
                 */
                Vector bledy = new Vector();

                for(int i=0;i<n;i++){
                    if(user_perm[i] != perm[i]){
                        bledy.add(i);
                    }
                }

                if(bledy.size() == 0){
                    System.out.println("Wygrana");
                    Date round_end = new Date();
                    //System.out.println("Koniec: " + round_format.format(round_end));
                    //System.out.println("Czas trwania: " + (double)(round_end.getTime() - round_start.getTime())/1000 + " sekundy");
                    logger.log(Level.INFO, "Czas trwania rundy nr " + runda + " to: " + (double)(round_end.getTime() - round_start.getTime())/1000 + " sekundy");
                    logger.log(Level.INFO, "Wynik: Wygrana");
                    break;
                }else{
                    int random_error = (int) bledy.get(new Random().nextInt(bledy.size()));
                    int error_pos = Arrays.asList(perm).indexOf(user_perm[random_error]);
                    if(error_pos > random_error){
                        System.out.println("zle, liczba " + user_perm[random_error] + " powinna znajdować się na prawo od obecnej pozycji");
                    }else{
                        System.out.println("zle, liczba " + user_perm[random_error] + " powinna znajdować się na lewo od obecnej pozycji");
                    }
                }
            }else{
                throw new Exception_bledne_dane("Wprowadzono bledne dane");
            }

            /**
             * koniec rundy
             */
            Date round_end = new Date();
            //System.out.println("Koniec: " + round_format.format(round_end));
            //System.out.println("Czas trwania: " + (double)(round_end.getTime() - round_start.getTime())/1000 + " sekundy");
            logger.log(Level.INFO, "Czas trwania rundy nr " + runda + " to: " + (double)(round_end.getTime() - round_start.getTime())/1000 + " sekundy");

            /**
             * zwiekszamy licznik rund
             */
            runda++;
        }

        /**
         * zakonczenie logowania komunikatow
         */
        //System.out.println(user_answers);
        logger.exiting(Main.class.getName(), "main");

    }
}
