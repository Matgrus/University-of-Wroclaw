import algorithms.*;

public class Main {
    public static void main(String[] args){
        BST<Integer> test = new BST<>();
        for(int i=0; i< 25; i++) {
            test.insert(i);
        }
        System.out.println();
        System.out.println(test.toString());

        System.out.println();
        System.out.println("rozmiar drzewa: " + test.size());

        System.out.println();
        System.out.println("search 6: " + test.search(6));
        System.out.println();
        System.out.println("search 50: " + test.search(50));

        System.out.println();
        System.out.println("remove 10: ");
        test.remove(10);
        System.out.println(test.toString());

        System.out.println();
        System.out.println("remove 50: ");
        test.remove(50);
        System.out.println(test.toString());

        System.out.println();
        System.out.println("max: " + test.max());

        System.out.println();
        System.out.println("min: " + test.min());

        System.out.println();
        System.out.println("clear");
        test.clear();
        System.out.println(test.toString());

        System.out.println("=====================");

        BST<String> test2 = new BST<>();
        test2.insert("a");
        test2.insert("b");
        test2.insert("c");
        test2.insert("d");
        test2.insert("e");
        test2.insert("f");
        test2.insert("g");
        test2.insert("h");
        test2.insert("i");
        test2.insert("j");
        test2.insert("k");
        test2.insert("l");

        System.out.println();
        System.out.println(test2.toString());

        System.out.println();
        System.out.println("rozmiar: " + test2.size());

        System.out.println();
        System.out.println("search d: " + test2.search("d"));

        System.out.println();
        System.out.println("remove g: ");
        test2.remove("g");
        System.out.println(test2.toString());

        System.out.println();
        System.out.println("max: " + test2.max());

        System.out.println();
        System.out.println("min: " + test2.min());

        System.out.println();
        System.out.println("clear: ");
        test2.clear();
        System.out.println(test2.toString());

    }

}