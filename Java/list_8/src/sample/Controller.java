package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.text.Text;

import java.math.BigInteger;

public class Controller {

    public Button button_7;
    public Button button_8;
    public Button button_9;
    public Button button_div;
    public Button button_DEL;
    public Button button_CLR;
    public Button button_4;
    public Button button_5;
    public Button button_6;
    public Button button_mult;
    public Button button_SIGN;
    public Button button_NEWT;
    public Button button_1;
    public Button button_2;
    public Button button_3;
    public Button button_sub;
    public Button button_fact;
    public Button button_MOD;
    public Button button_0;
    public Button button_res;
    public Button button_add;
    public Button button_POW;
    public Button button_BIN;
    public Button button_DEC;
    public Button button_HEX;
    public Button button_A;
    public Button button_B;
    public Button button_C;
    public Button button_D;
    public Button button_E;
    public Button button_F;
    @FXML
    private Text output;

    private BigInteger number1 = new BigInteger("0");
    private String operator = "";
    private boolean start = true;

    private String mode = "DEC";

    private BigInteger Fact(BigInteger number1){
        BigInteger res = new BigInteger("1");
        for(BigInteger i = new BigInteger("1"); i.compareTo(number1) < 1; i = new BigInteger(String.valueOf(i.add(new BigInteger("1"))))) {
            res = res.multiply(i);
        }
        return res;
    }

    private BigInteger calculate(BigInteger number1, BigInteger number2, String operator){
        switch (operator){
            case "+":
                return number1.add(number2);
            case "-":
                return number1.subtract(number2);
            case "*":
                return number1.multiply(number2);
            case "/":
                if(number2.equals(BigInteger.valueOf(0))){
                    return new BigInteger("0");
                }else{
                    return number1.divide(number2);
                }
            case "NEWT":
                return Fact(number1).divide(Fact(number2).multiply(Fact(number1.subtract(number2))));
            case "MOD":
                return number1.mod(number2);
            case "POW":
                return number1.pow(number2.intValue());
        }

        System.out.println("Unknown operator - " + operator);
        return new BigInteger("0");
    }

    @FXML
    private void numbers(ActionEvent event){
        if(((Button) event.getSource()).getText().equals("SIGN")){
            output.setText("-" + output.getText());
        }else if(((Button) event.getSource()).getText().equals("DEL")){
            if(!output.getText().isEmpty()) {
                output.setText(output.getText().substring(0, output.getText().length() - 1));
            }
        }else{

            if (start) {
                output.setText("");
                start = false;
            }

            String value = ((Button) event.getSource()).getText();
            output.setText(output.getText() + value);
        }
    }

    @FXML
    private void operations(ActionEvent event) {

        String value = ((Button) event.getSource()).getText();
        BigInteger number2 = null;

        if (operator.isEmpty()) {
            if(!output.getText().isEmpty()){
                switch(mode){
                    case "DEC":
                        number1 = new BigInteger(output.getText());
                        break;
                    case "BIN":
                        number1 = new BigInteger(output.getText(), 2);
                        break;
                    case "HEX":
                        number1 = new BigInteger(output.getText(), 16);
                }
            }
        } else {
            switch(mode){
                case "DEC":
                    number2 = new BigInteger(output.getText());
                    break;
                case "BIN":
                    number2 = new BigInteger(output.getText(), 2);
                    break;
                case "HEX":
                    number2 = new BigInteger(output.getText(), 16);
            }
        }

        if (!"=".equals(value)) {
            switch (value) {
                case "DEC":
                    button_A.setDisable(true);
                    button_B.setDisable(true);
                    button_C.setDisable(true);
                    button_D.setDisable(true);
                    button_E.setDisable(true);
                    button_F.setDisable(true);
                    button_DEC.setDisable(true);
                    button_BIN.setDisable(false);
                    button_HEX.setDisable(false);
                    button_0.setDisable(false);
                    button_1.setDisable(false);
                    button_2.setDisable(false);
                    button_3.setDisable(false);
                    button_4.setDisable(false);
                    button_5.setDisable(false);
                    button_6.setDisable(false);
                    button_7.setDisable(false);
                    button_8.setDisable(false);
                    button_9.setDisable(false);
                    button_SIGN.setDisable(false);
                    //button_DEL.setDisable(false);
                    mode = "DEC";
                    output.setText("");
                    break;
                case "BIN":
                    button_A.setDisable(true);
                    button_B.setDisable(true);
                    button_C.setDisable(true);
                    button_D.setDisable(true);
                    button_E.setDisable(true);
                    button_F.setDisable(true);
                    button_DEC.setDisable(false);
                    button_BIN.setDisable(true);
                    button_HEX.setDisable(false);
                    button_0.setDisable(false);
                    button_1.setDisable(false);
                    button_2.setDisable(true);
                    button_3.setDisable(true);
                    button_4.setDisable(true);
                    button_5.setDisable(true);
                    button_6.setDisable(true);
                    button_7.setDisable(true);
                    button_8.setDisable(true);
                    button_9.setDisable(true);
                    button_SIGN.setDisable(true);
                    //button_DEL.setDisable(true);
                    mode = "BIN";
                    output.setText("");
                    break;
                case "HEX":
                    button_A.setDisable(false);
                    button_B.setDisable(false);
                    button_C.setDisable(false);
                    button_D.setDisable(false);
                    button_E.setDisable(false);
                    button_F.setDisable(false);
                    button_DEC.setDisable(false);
                    button_BIN.setDisable(false);
                    button_HEX.setDisable(true);
                    button_0.setDisable(false);
                    button_1.setDisable(false);
                    button_2.setDisable(false);
                    button_3.setDisable(false);
                    button_4.setDisable(false);
                    button_5.setDisable(false);
                    button_6.setDisable(false);
                    button_7.setDisable(false);
                    button_8.setDisable(false);
                    button_9.setDisable(false);
                    button_SIGN.setDisable(true);
                    //button_DEL.setDisable(true);
                    mode = "HEX";
                    output.setText("");
                    break;
                /*case "DEL":
                    switch (mode){
                        case "DEC":
                            output.setText(String.valueOf(number1.divide(BigInteger.valueOf(10))));
                            number1 = new BigInteger(output.getText());
                            break;
                        case "BIN":
                        case "HEX":
                            String h = String.valueOf(number1);
                            output.setText(h.substring(0, h.length() - 1));
                            number1 = new BigInteger(output.getText());
                            break;
                    }
                    operator = "";
                    break; */
                case "C":
                    output.setText("0");
                    number1 = new BigInteger(output.getText());
                    operator = "";
                    break;
                /*case "SIGN":
                    output.setText(String.valueOf(number1.multiply(BigInteger.valueOf(-1))));
                    number1 = new BigInteger(output.getText());
                    operator = "";
                    break; */
                case "N!":
                    switch (mode){
                        case "DEC":
                            output.setText(String.valueOf(Fact(number1)));
                            number1 = new BigInteger(output.getText());
                            break;
                        case "BIN":
                            output.setText(Fact(number1).toString(2));
                            number1 = new BigInteger(output.getText(), 2);
                            break;
                        case "HEX":
                            output.setText(Fact(number1).toString(16));
                            number1 = new BigInteger(output.getText(), 16);
                            break;
                    }
                    operator = "";
                    break;
                case "+":
                    operator = "+";
                    break;
                case "-":
                    operator = "-";
                    break;
                case "*":
                    operator = "*";
                    break;
                case "/":
                    operator = "/";
                    break;
                case "MOD":
                    operator = "MOD";
                    break;
                case "NEWT":
                    operator = "NEWT";
                    break;
                case "POW":
                    operator = "POW";
                    break;
                default:
                    operator = "";
            }

            start = true;
        } else {
            if (operator.isEmpty()) {
                System.out.println("Error");
            } else {
                switch(mode){
                    case "DEC":
                        output.setText(String.valueOf(calculate(number1, number2, operator)));
                        break;
                    case "BIN":
                        output.setText(calculate(number1, number2, operator).toString(2));
                        break;
                    case "HEX":
                        output.setText(calculate(number1, number2, operator).toString(16));
                }
                operator = "";
                start = true;
            }
        }
    }

    public void initialize(){
        output.setText("0");
        button_A.setDisable(true);
        button_B.setDisable(true);
        button_C.setDisable(true);
        button_D.setDisable(true);
        button_E.setDisable(true);
        button_F.setDisable(true);
        button_DEC.setDisable(true);
    }

}
