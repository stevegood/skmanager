/**
 * User: steve
 * Date: 10/9/13
 * Time: 2:25 PM
 */

jQuery(function($){
    var $regForm = $('#registration_form'),
        $usernameField = $('#username'),
        $passwordField = $('#password'),
        $password2Field = $('#password2');

    // handle registration form submission
    $regForm.on('submit', function(e){
        var formInvalid = (!$usernameField.val().length || !$passwordField.val().length || !$password2Field.val().length || $passwordField.val() !== $password2Field.val())
        if (formInvalid) {
            e.preventDefault();
            alert('Please verify that a username was provided and that both password fields match.');
        }
        return !formInvalid;
    });
});