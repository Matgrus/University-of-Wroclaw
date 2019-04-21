class Kolekcja<V, K extends Comparable<K>>
{
    V value;
    K key;
    Kolekcja<V, K> next;
    
    public Kolekcja(V value, K key){
        this.value = value;
        this.key = key;
        this.next = null;
    }
    public Kolekcja(){}
    public Kolekcja<V, K> del(){
        Kolekcja<V, K> res = this.next;
        if(this.next != null){
            this.next = this.next.next;
        }
        return res;
    }
    public void ins(V value, K key){
        if(this.next != null){
            if (this.next.key.compareTo(key) >= 0){
                Kolekcja<V,K> x=this.next;
                this.next=new Kolekcja<V,K>(value, key);
                this.next.next=x;
            }else{
                this.next.ins(value, key);
            }
        }else{
            this.next=new Kolekcja<V,K>(value, key);
        }
    }
    public void print(){
     if (this.next != null){
            System.out.println("Klucz: " + this.next.key + ", wartosc: " + this.next.value);
            this.next.print();
        }
    }
}