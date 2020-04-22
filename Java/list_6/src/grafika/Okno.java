package grafika;

import java.awt.*;
import java.awt.event.*;
import java.util.LinkedList;

public class Okno extends Frame {

    private LinkedList<Kreska> kreski;

    private WindowListener frame_list = new WindowAdapter()
    {
        @Override
        public void windowClosing (WindowEvent ev)
        {
            Okno.this.dispose();
        }
    };

    private Point punkt_start = new Point();
    private Point punkt_koniec = new Point();
    private Point punkt_tymcz = new Point();

    private MouseListener mouse_list = new MouseAdapter()
    {
        @Override
        public void mousePressed(MouseEvent ev)
        {
            punkt_start = ev.getPoint();
            punkt_koniec = ev.getPoint();
        }
        @Override
        public void mouseReleased(MouseEvent ev)
        {
            if(punkt_koniec.x <= powierzchnia.getWidth() && punkt_koniec.x >= 0 && punkt_koniec.y >= 0 && punkt_koniec.y <= powierzchnia.getHeight()){
                kreski.add(new Kreska(punkt_start, punkt_koniec, kolor_akt));
            }
            punkt_start = new Point();
            punkt_koniec = new Point();
            punkt_tymcz = null;
            repaint();
        }
    };

    private MouseMotionListener mouse_motion_list = new MouseMotionAdapter()
    {
        @Override
        public void mouseDragged(MouseEvent ev)
        {
            punkt_tymcz = ev.getPoint();
            punkt_koniec = ev.getPoint();
            repaint();
        }
    };

    private KeyListener key_list = new KeyAdapter()
    {
        @Override
        public void keyReleased(KeyEvent ev) {
            switch (ev.getKeyCode()) {
                case KeyEvent.VK_BACK_SPACE:
                    kreski.clear();
                    repaint();
                    break;
                case KeyEvent.VK_F:
                    if(!kreski.isEmpty()){
                        kreski.removeFirst();
                    }
                    repaint();
                    break;
                case KeyEvent.VK_L:
                    if(!kreski.isEmpty()){
                        kreski.removeLast();
                    }
                    repaint();
                    break;
                default:
                    break;
            }
        }
    };

    private Panel opcje = new Panel();

    private Canvas powierzchnia = new Canvas();

    private Color kolor_akt = Color.BLACK;

    public Okno() {

        super("KOLOROWY RYSUNEK");
        setSize(1024, 768);
        menu();

        this.kreski = new LinkedList<>();
        setLayout(new BorderLayout());
        add(opcje, BorderLayout.WEST);
        add(powierzchnia, BorderLayout.CENTER);
        powierzchnia.requestFocus();
        powierzchnia.addMouseListener(mouse_list);
        powierzchnia.addMouseMotionListener(mouse_motion_list);
        powierzchnia.addKeyListener(key_list);
        addWindowListener(frame_list);
        setVisible(true);
    }

    private void menu() {

        List kolory = new List(10, false);
        kolory.add("CZARNY");
        kolory.add("NIEBIESKI");
        kolory.add("ZIELONY");
        kolory.add("CZERWONY");
        kolory.add("CYAN");
        kolory.add("SZARY");
        kolory.add("MAGENTA");
        kolory.add("POMARANCZOWY");
        kolory.add("ZOLTY");
        kolory.add("ROZOWY");

        opcje.add(kolory);
        kolory.setBackground(Color.LIGHT_GRAY);
        opcje.setBackground(Color.GRAY);



        kolory.addItemListener(new ItemListener(){
            @Override
            public void itemStateChanged(ItemEvent ev){
                switch(kolory.getSelectedItem()) {
                    case "CZARNY":
                        kolor_akt=Color.BLACK;
                        break;
                    case "NIEBIESKI":
                        kolor_akt=Color.BLUE;
                        break;
                    case "ZIELONY":
                        kolor_akt=Color.GREEN;
                        break;
                    case "CZERWONY":
                        kolor_akt=Color.RED;
                        break;
                    case "CYAN":
                        kolor_akt=Color.CYAN;
                        break;
                    case "SZARY":
                        kolor_akt=Color.GRAY;
                        break;
                    case "MAGENTA":
                        kolor_akt=Color.MAGENTA;
                        break;
                    case "POMARANCZOWY":
                        kolor_akt=Color.ORANGE;
                        break;
                    case "ZOLTY":
                        kolor_akt=Color.YELLOW;
                        break;
                    case "ROZOWY":
                        kolor_akt=Color.PINK;
                        break;
                    default:
                        break;
                }
            }
        });
    }

    public void paint(Graphics g)
    {
        g = powierzchnia.getGraphics();
        g.clearRect(0, 0, getWidth(), getHeight());
        for (Kreska p : kreski) {
            g.setColor(p.kolor);
            g.drawLine(p.poczatek.x, p.poczatek.y, p.koniec.x, p.koniec.y);
        }

        if (punkt_tymcz != null) {
            g.setColor(Color.GRAY);
            g.drawLine(punkt_start.x, punkt_start.y, punkt_tymcz.x, punkt_tymcz.y);
        }
    }

}
