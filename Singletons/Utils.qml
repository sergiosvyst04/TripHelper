import QtQuick 2.7

pragma Singleton

QtObject {

    function validateEmail(email) {
        if(email.length < 4) {
            return false
        }
        else {
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }
    }

    function validatePassword(password) {
        if(password.length < 8) {
            return false
        }
        else {
            return true
        }
    }

    function validateConfirmPassword(firstAttempt, secondAttempt){
        if(firstAttempt === secondAttempt)
            return true
        else
            return false
    }
}
