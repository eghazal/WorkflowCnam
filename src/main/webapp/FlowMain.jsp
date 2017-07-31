<%-- 
    Document   : workflow
    Created on : Jul 23, 2017, 9:26:04 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Workflow</title>
    </head>
    <body>
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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/raphael-min.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/flowchart.min.js"></script>
        <script src="js/jquery.flowchart.js"></script>
        <script src="js/workflow.js"></script>
        <script src="js/jquery.bpopup.min.js"></script>
        <link rel="stylesheet" href="css/style.css" />
</html>
