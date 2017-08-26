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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="js/workflowList.js" type="text/javascript"></script>
</head>
<body>

<div class="container">
<% if (session.getAttribute("userName") == null) {%>
<jsp:forward page="/index.jsp"/>
<% } %>


<h3>Welcome  ${userName}</h3>

  <p>Below are the list of your workflows : </p>
  <p>Please select one to edit, or press create to create a new workflow.</p>                                         
  <div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" 
            type="button" 
            data-toggle="dropdown"
            id="workflowList">List of workflows :  
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">HTML</a></li>
      <li><a href="#">CSS</a></li>
      <li><a href="#">JavaScript</a></li>
    </ul>
  </div>
</div>
</body>
<script  language="javascript">
    var workflowId=-2;
    var userName = '<%= session.getAttribute("userName") %>';
    //var apiURL = "localhost:9999";
    var apiURL = "https://workflowapi-176706.appspot.com";
    $( document ).ready(function() {
     getWorkFlowLists();
    });
    
  function getWorkFlowLists() {
      console.log(apiURL + "/GetWorkflowsByUsers");
      console.log(userName);
    return $.ajax({
        url: "http://query.yahooapis.com/v1/public/yql",
        // the name of the callback parameter, as specified by the YQL service
        jsonp: "callback",
        // tell jQuery we're expecting JSONP
        dataType: "jsonp",
        // tell YQL what we want and that we want JSON
        data: {
            q: "select * from json where " +
                    +"url=" + apiURL + "/GetWorkflowsByUsers?userName="+userName,
            type: 'GET',
            crossDomain: true,
            format: "json"
        },
        // work with the response
        success: function (response) {
            console.log(response);
            return JSON.stringify(response);
        }
    });
}
</script>
</html>
   
