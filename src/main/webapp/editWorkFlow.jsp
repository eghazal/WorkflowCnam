<%-- 
    Document   : workflowList
    Created on : Aug 24, 2017, 9:13:07 PM
    Author     : eghaz
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="css/common.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/waitingDialog.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!--<link rel="stylesheet" href="css/style.css" />-->
        <link rel="stylesheet" href="css/index.css" />
    </head>
    <body>

        <div class="container">
            <% if (session.getAttribute("userName") == null) {%>
            <jsp:forward page="/index.jsp"/>
            <% }%>


            <h3>Welcome  ${userName}</h3>
        <a href="#" class="topcornerright" onclick="signOut();">Sign out</a>
            <div></div>
            <p>Below are the list of your workflows.</p>
            <p>Please select one to edit, or press create to create a new workflow.</p>                                         
            <div class="dropdown" style="display:inline">
                <button class="btn btn-primary dropdown-toggle" 
                        type="button" 
                        data-toggle="dropdown"
                        id="btnWorkflowList">Select a worklfow  
                    <span class="caret"></span></button>
                <ul class="dropdown-menu" id="workflowsList" style="overflow: scroll;height: 20em">
                    <li><a href="#">HTML</a></li>
                    <li><a href="#">CSS</a></li>
                    <li><a href="#">JavaScript</a></li>
                </ul>
            </div>
            <button class="btn btn-primary " 
                    type="button" 
                    id="btnNewWorkflow"
                    style="margin-left:  10px;"
                    style="display:inline" onclick="redirectToWorkFlow()">New workflow</button>
        </div>
    </body>
    <script  language="javascript">
        var workflowId = - 2;
        var userName = '<%= session.getAttribute("userName")%>';
        //var apiURL = "http://localhost:9999";
        var apiURL="https://workflowapi-176706.appspot.com";
        $(document).ready(function () {
        waitingDialog.show("Please wait while loading your workflows...");
        getWorkFlowLists();
        });
        function getWorkFlowLists() {
        $.getJSON(apiURL + "/GetWorkflowsByUsers?userName=" + userName, function (data) {
        console.log(data);
        var varWorkflowList = '';
        $.each(data, function (key, val) {


        varWorkflowList += "<li  class=\"list-group-item\" id='" + val["wf_id"] + "'\n\
                                                                    onclick=\"redirectToWorkFlow(" + val["wf_id"] + ",'" + val["wf_desc"]+"')\">"
                + val["wf_desc"] +
                "</li>";
        });
        document.getElementById("workflowsList").innerHTML = varWorkflowList;
        waitingDialog.hide();
        });
        }
        ;
        function redirectToWorkFlow(workflowId = - 1, workflowDesc = '') {
        window.location.href = 'editWorkFlowWithTasks.jsp?&wfId=' + workflowId + '&wfDesc=' + workflowDesc;
        }
        function onLoad() {
                gapi.load('auth2', function () {
                    gapi.auth2.init();
                });
            }

            function signOut() {
                window.location.href = "https://accounts.google.com/Logout";
                //window.location.pathname = 'google-oauth-example/index.jsp';
            }
    </script>
</html>

