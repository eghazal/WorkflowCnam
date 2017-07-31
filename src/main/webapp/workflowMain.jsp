<%-- 
    Document   : WorkflowMain
    Created on : Jul 29, 2017, 2:10:36 PM
    Author     : eghaz
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
<head>
<!--Meta Data-->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="google-signin-client_id" content="966400828938-vc6umm781j1nse8cg6cupgc2g3cc0ake.apps.googleusercontent.com">

<!--Scripts-->
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="js/raphael-min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/flowchart.min.js"></script>
<script src="js/jquery.flowchart.js"></script>
<script src="js/workflow.js"></script>
<script src="js/jquery.bpopup.min.js"></script>

<!--Styles-->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />

<title>Welcome</title>
</head>
<body>

<!--  forward to index page for login if user info is not in session  -->
<% if (session.getAttribute("userName") == null) {%>
<jsp:forward page="/index.jsp"/>
<% } %>

<h3>Welcome  ${userName}</h3>
 <div id="layout" class="row noMargin">
		<div id="menuCont" class="col-md-3 col-sm-4 col-xs-12 noPadding">
		
			<div id="dragDropCont" class="btn btnMenu">SIMPLE MODE</div>
			<div class="dragDropMenu menuWorkflow"></div>
			
			<div id="manualCont" class="btn btnMenu">ADVANCED MODE</div>
			<div class="manualMenu menuWorkflow">
				<textarea id="manualFlowChart"></textarea>
				<div class="clear"></div>
				<div class="btn btnRender">RENDER WORKFLOW</div>
			</div>
			
		</div>
		<div class="flowchart col-md-9 col-sm-8 col-xs-12 noPadding">st=>start: User login
op=>operation: Login operation
cond=>condition: Login successful Yes or No?
e=>end: Into admin panel

st->op->cond
cond(yes)->e
cond(no)->op</div>
        </div>
 <div class="taskPopup" id="taskPopup">
			<div class="taskPopupCont">
				<div class="taskCloseCont"><img src="img/close.png" class="closeModule taskClose" /></div>
				<div class="row noMargin">
					<div class="col-md-12 col-sm-12 col-xs-12 noPadding taskTitle">Task Settings</div>
				</div>
				<div class="row noMargin taskRow">
					<div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Name</label></div>
					<div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask" /></div>
				</div>
				<div class="row noMargin taskRow">
					<div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Description</label></div>
					<div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask" /></div>
				</div>
				<div class="row noMargin taskRow">
					<div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Email</label></div>
					<div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask" /></div>
				</div>
				<div class="row noMargin taskRow">
					<div class="col-md-12 col-sm-12 col-xs-12 noPadding">
						<div class="btn btnDelete">DELETE</div>
						<div class="btn btnSave">SAVE</div>
					</div>
				</div>
			</div>
		</div>
       
<a href="#" onclick="signOut();">Sign out</a>
<script>
     function onLoad() {
      gapi.load('auth2', function() {
        gapi.auth2.init();
      });
    }
    
  function signOut() {
    window.location.href="https://accounts.google.com/Logout";
     //window.location.pathname = 'google-oauth-example/index.jsp';
  }
</script>
</body>
</html>
