package algorithms;

public interface Dict<T extends Comparable<T>>
{
    boolean search(T val);

    void insert(T val);

    void remove(T val);

    T max();

    T min();
}
