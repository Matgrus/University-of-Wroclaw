class Szeregowy extends Stopnie_wojskowe{
    public int Stopien(){
        return 1;
    }
    public Szeregowy(String s){
        this.ranga = s;
    }
    public Szeregowy(){
        this.ranga = "Szeregowy";
    }
}
class Kapral extends Stopnie_wojskowe{
    public int Stopien(){
        return 3;
    }
    public Kapral(String s){
        this.ranga = s;
    }
    public Kapral(){
        this.ranga = "Kapral";
    }

}
class Kapitan extends Stopnie_wojskowe {
    public int Stopien() {
        return 14;
    }
    public Kapitan (String s) {
        this.ranga = s;
    }
    public Kapitan(){
        this.ranga = "Kapitan";
    }
}
class General extends Stopnie_wojskowe {
    public int Stopien() {
        return 21;
    }
    public General (String s){
        this.ranga = s;
    }
    public General(){
        this.ranga = "General";
    }
}