<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <script src="https://smtpjs.com/smtp.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/alertify.js" type="text/javascript"></script>
        <script src="js/emailSender.js" type="text/javascript"></script>
        <meta name="google-signin-scope" content="">
        <meta name="google-signin-client_id"
              content="966400828938-vc6umm781j1nse8cg6cupgc2g3cc0ake.apps.googleusercontent.com">

        <!--Styles-->
        <link rel="stylesheet" href="css/index.css" />
        <link href="css/alertify.core.css" rel="stylesheet" type="text/css"/>
        <link href="css/alertify.default.css" rel="stylesheet" type="text/css"/>
        <meta name="viewport" content="width=device-width">
        <style>
            .alertify-log-custom {
                background: blue;
            }
        </style>
        <title>Login</title>
    </head>
    <body class="bg">
        <!--<div class="g-signin2 loginBtn loginBtn--google" data-onsuccess="onSignIn"></div>-->
        <div class="g-signin2 " data-onsuccess="onSignIn"></div>
        <script>
            var userProfile;
            var redirectForm;
            function onSignIn(googleUser) {

                var profile = googleUser.getBasicProfile();
                userProfile = profile;
                console.log('ID: ' + profile.getId());
                console.log('Name: ' + profile.getName());
                console.log('Image URL: ' + profile.getImageUrl());
                console.log('Email: ' + profile.getEmail());
                console.log('id_token: ' + googleUser.getAuthResponse().id_token);
                console.log('profile : ' + profile);
                var redirectUrl = 'workflowMain';
                var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="id_token" value="' +
                        googleUser.getAuthResponse().id_token + '" />' +
                        '</form>');
                redirectForm = form;
                getExistingUser().done(function (response) {
                    console.log(response);
                    if (_UserContains(response, profile.getName())) {
                        redirectToWorkflowPage();
                    } else {
                        showSignUpMessage();
                    }
                })

            }
            function _UserContains(usersList, value) {
                let contains = false;
                Object.keys(usersList).some(key => {
                    contains = typeof usersList[key] === 'object' ?
                            _UserContains(usersList[key], value) :
                            usersList[key] === value;
                    return contains;
                });
                return contains;
            }
            function redirectToWorkflowPage() {
                $('body').append(redirectForm);
                redirectForm.submit();
            }
            function showSignUpMessage() {
                alertify.set({
                    buttonReverse: true,
                    labels: {ok: "Sign Up", cancel: "Cancel"},
                    delay: 10000
                });
                alertify.confirm("This account doens\'t exist in our database, would you like to sign up ?", function (e) {
                    if (e) {
                        alertify.log("Signin Up, please wait.");
                        signUpUsers1();
                        var subject = "New sign up."
                        var content = "New user has just signed up. Name : " + userProfile.getName() + "and email : " + userProfile.getEmail() + ".";
                        sendEmail("eghazal27@gmail.com", subject, content);
                        redirectToWorkflowPage();

                    } else {
                        return "Cancel";
                    }
                });
            }
            function getExistingUser() {
               return jQuery.ajax({
                    type: "GET",
                    url: 'https://workflowapi-176706.appspot.com/GetUsers',
                    dataType: "jsonp",
                    cache: false,
                    crossDomain: true,
                    processData: true,

                    success: function (data) {
                        return (JSON.stringify(data));
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("error");
                    }
                });
            }
            function signUpUsers1(){
                 return jQuery.ajax({
                    type: "POST",
                    url: "https://workflowapi-176706.appspot.com/AddUser?UserName=" + userProfile.getName() +"&UserMail=" + userProfile.getEmail()+"&UserGender=NA&UserBirthDate=2000-01-17",
                    cache: false,
                    crossDomain: true,
                    processData: true,

                    success: function (data) {
                        return true;
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("error");
                    }
                });
            }
            function signUpUsers() {

                return $.ajax({
                    url: "http://query.yahooapis.com/v1/public/yql",
                    // the name of the callback parameter, as specified by the YQL service
                    jsonp: "callback",
                    // tell jQuery we're expecting JSONP
                    dataType: "jsonp",
                    // tell YQL what we want and that we want JSON
                    data: {
                        q: "select * from json where " +
                                +"url=\"https://workflowapi-176706.appspot.com/AddUser?" +
                                +"UserName=" + userProfile.getName() +
                                +"&UserMail=" + userProfile.getEmail() +
                                +"&UserGender='NA'&UserBirthDate=2000-01-17?format=json\"",
                        format: "json"
                    },
                    // work with the response
                    success: function (response) {
                        return true;
                    }
                });
            }
            function sendEmail(to, subject, body) {
            Email.send("workflow2017gt@gmail.com", to, subject, body,
            "smtp.gmail.com",
            "workflow2017gt",
            "P@ssw0rd2017")
}

        </script>
    </body>
</html>