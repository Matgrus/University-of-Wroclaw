package algorithms;

public class BST<T extends Comparable<T>> implements Dict<T> {

    private class Node <T extends Comparable<T>> {
        Node <T> left;
        Node <T> right;
        Node <T> parent;
        T data;

        public Node(){
           right = null;
           left = null;
           parent = null;
           data = null;
        }

        public void replace(Node x){
            if(this == root){
                root = x;
            }else if(this == this.parent.left){
                this.parent.left = x;
            }else{
                this.parent.right = x;
            }
            if (x != null){
                x.parent = this.parent;
            }
        }
    }

    public Node<T> root;

    int size;

    public BST(){
        root = new Node<>();
        size = 0;
        root.parent = null;
    }

    @Override
    public void insert(T elem) throws NullPointerException{
        if (elem == null){
            throw new NullPointerException("Nie mozna wlozyc wartosci null");
        }

        Node ins_node = new Node<T>();
        ins_node.data = elem;

        if (size() == 0){
            root = ins_node;
        }else{
            Node temp = root;
            Node temp_parent = null;
            while(temp != null){
                temp_parent = temp;
                if(ins_node.data.compareTo(temp.data) < 0){
                    temp = temp.left;
                }else{
                    temp = temp.right;
                }
            }
            ins_node.parent = temp_parent;
            if (ins_node.data.compareTo(temp_parent.data) < 0){
                temp_parent.left = ins_node;
            }else{
                temp_parent.right = ins_node;
            }
        }
        size += 1;
    }

    private Node getNode(T elem) {
        if (size == 0){
            return null;
        }
        Node temp = root;
        Node x = new Node<T>();
        x.data = elem;
        while (temp != null){
            if (x.data.compareTo(temp.data) == 0){
                return temp;
            }else if (x.data.compareTo(temp.data) < 0){
                temp = temp.left;
            }else{
                temp = temp.right;
            }
        }
        return null;
    }

    @Override
    public boolean search(T elem) {
        return getNode(elem) != null;
    }

    @Override
    public void remove(T elem) {
        if (search(elem)){
            Node x = getNode(elem);
            if (x.left == null && x.right == null){
                x.replace(null);
            }else if (x.left == null) {
                x.replace(x.right);
            }else if (x.right == null) {
                x.replace(x.left);
            }else{
                Node min_n = min_node(x.right);
                remove((T) min_n.data);
                x.data = min_n.data;
            }
        }else{
            System.out.println("nie ma takiej wartosci");
        }
    }


    @Override
    public String toString(){
        return help_tostr(root);
    }

    private String help_tostr(Node node){
        if(node == null){
            return "leaf";
        }else{
            return "(node: " + node.data + " " + help_tostr(node.left) + " " + help_tostr(node.right) + ")";
        }
    }


    @Override
    public T min(){
        return min_node(root).data;
    }

    @Override
    public T max(){
        return max_node(root).data;
    }

    private Node<T> min_node(Node<T> node){
        Node temp = node;
        while (temp.left != null){
            temp = temp.left;
        }
        return temp;
    }

    private Node<T> max_node(Node<T> node){
        Node temp = node;
        while (temp.right != null){
            temp = temp.right;
        }
        return temp;
    }

    public int size() {
        return size;
    }

    public void clear(){
        root = null;
        size = 0;
    }

}