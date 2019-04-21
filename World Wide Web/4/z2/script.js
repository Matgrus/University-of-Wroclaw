
function check_nrkonta(){
    var numer=document.getElementById('nr_konta').value;
    var regex = /[0-9]{26}/;
    if(regex.test(numer) == false){
        document.getElementById("konto_check").innerHTML = "<font color=\"red\">Numer konta jest nieprawidłowy!</font>";
        return false;
    }else{
        document.getElementById("konto_check").innerHTML = "<font color=\"green\">OK</font>";
        return true;
    }
}

function check_pesel(){
    var pesel=document.getElementById('pesel').value;
    var regex = /[0-9]{11}/;
    if (regex.test(pesel) == false) {
        document.getElementById("pesel_check").innerHTML = "<font color=\"red\">Pesel jest nieprawidłowy!</font>";
        return false;
    }else{
        document.getElementById("pesel_check").innerHTML = "<font color=\"green\">OK</font>";
        return true;
    }
}

function check_dataur(){
    var data=document.getElementById('data_ur').value;
    var regex= /^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[012])\.[0-9]{4}$/; 
    if(regex.test(data) == false){
        document.getElementById("data_check").innerHTML = "<font color=\"red\">Data urodzenia jest nieprawidłowa!</font>";
        return false;
    }else{
        document.getElementById("data_check").innerHTML = "<font color=\"green\">OK</font>";
        return true;
    }
}

function check_mail(){
    var mail=document.getElementById('mail').value;
    var regex = /^[0-9a-zA-Z_.-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,3}$/;
    if(regex.test(mail) == false){
        document.getElementById("mail_check").innerHTML = "<font color=\"red\">Adres e-mail jest nieprawidłowy!</font>";
        return false;
    }else{
        document.getElementById("mail_check").innerHTML = "<font color=\"green\">OK</font>";
        return true;
    }
}

function check_form(){
    if(!check_nrkonta() || !check_pesel() || !check_dataur() || !check_mail()){
        alert("Wszystkie pola muszą być prawidłowo wypełnione!");
    }else{
        alert("WYSŁANO");
    }
}

