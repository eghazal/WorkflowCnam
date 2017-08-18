<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-scope" content="">
<meta name="google-signin-client_id"
     content="966400828938-vc6umm781j1nse8cg6cupgc2g3cc0ake.apps.googleusercontent.com">

<!--Styles-->
<link rel="stylesheet" href="css/index.css" />
<title>Login</title>
</head>
<body class="bg">
	<!--<div class="g-signin2 loginBtn loginBtn--google" data-onsuccess="onSignIn"></div>-->
        <div class="g-signin2 " data-onsuccess="onSignIn"></div>
	<script>
	function onSignIn(googleUser) {
           
      var profile = googleUser.getBasicProfile();
      console.log('ID: ' + profile.getId());
      console.log('Name: ' + profile.getName());
      console.log('Image URL: ' + profile.getImageUrl());
      console.log('Email: ' + profile.getEmail());
      console.log('id_token: ' + googleUser.getAuthResponse().id_token);
      console.log('profile : '+profile);
     //do not post above info to the server because that is not safe.
     //just send the id_token

      //var redirectUrl = 'welcome-page.jsp';
      var redirectUrl = 'workflowMain';
      //using jquery to post data dynamically
      var form = $('<form action="' + redirectUrl + '" method="post">' +
                          '<input type="text" name="id_token" value="' +
                           googleUser.getAuthResponse().id_token + '" />' +
                                                                '</form>');

    $('body').append(form);
    form.submit();
    }
	</script>
</body>
</html>