public class roman_numerals
{
    private static String aux(int x)
    {
    String res="";
    for(int i=0; i < 13 ; i++){
        while(x>= arabic[i]) {
            res+= roman[i];
            x-= arabic[i];
        }
    }
    return res;
}

    private static String[] roman =
            {"M", "CM", "D", "CD", "C","XC", "L", "XL", "X", "IX", "V", "IV", "I"};
    private static int[] arabic =
            {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};

    public static void main (String[] args)
    {
        int x;
        String res;
        for (int i=0; i<args.length; i++){
            try{
                x = Integer.valueOf(args[i]);
                if(x < 1 || x > 3999){
                    throw new IllegalArgumentException("liczba " + x + " spoza zakresu 1-3999");
                }else{
                    res = aux(x);
                }
            }
            catch(NumberFormatException e){
                res = "- błąd konwersji";
            }
            System.out.println(args[i] + " " + res);
        }
    }
}