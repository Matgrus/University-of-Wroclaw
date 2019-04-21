public abstract class Stopnie_wojskowe implements Comparable<Stopnie_wojskowe>
{
    public String ranga;
    public abstract int Stopien();
    public int compareTo(Stopnie_wojskowe korpus){
        if(korpus.Stopien() < this.Stopien()){
            return 1;
        }else if (korpus.Stopien() == this.Stopien()){
            return 0;
        }else{
            return -1;
        }
    }
    public String toString(){
        return "Ranga: " + ranga + ", stopien: " + Stopien();
    }
}