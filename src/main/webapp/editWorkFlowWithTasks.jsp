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
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/waitingDialog.js" type="text/javascript"></script>
        <script src="js/raphael.min.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/services.js"></script>
        <script src="js/flowchart.min.js"></script>
        <script src="js/jquery.flowchart.js"></script>
        <script src="js/workflow.js"></script>
        <script src="js/jquery.bpopup.min.js"></script>
        <link rel="stylesheet" href="css/jquery.datetimepicker.css">
        <script src="js/moment.js"></script>
        <script src="js/jquery.datetimepicker.full.min.js"></script>

        <!--Styles-->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/index.css" />

        <title>Welcome</title>
    </head>
    <body>

        <!--  forward to index page for login if user info is not in session  -->
        <% if (session.getAttribute("userName") == null) {%>
        <jsp:forward page="/index.jsp"/>
        <% } %>
        <input type="hidden" id="workflowId" value="<%
            if (request.getParameter("wfId") == null) {
                out.print("-1");
            } else {
                out.print(request.getParameter("wfId"));
            }
               %>" />
         <input type="hidden" id="workflowDesc" value="<%
            if (request.getParameter("wfDesc") == null) {
                out.print("-1");
            } else {
                out.print(request.getParameter("wfDesc"));
            }
               %>" />

        <h3>Welcome  ${userName}</h3>
        <a href="#" class="topcornerright" onclick="signOut();">Sign out</a>
        <a href="#" class="topcornerleft" onclick="home();">Home</a>

        <div id="layout" class="row noMargin">
            <div id="menuCont" class="col-md-3 col-sm-4 col-xs-12 noPadding">
                <label for="inputsm">Workflow description</label>
                <input class="form-control input-sm" id="wfDesc" type="text">
                <div id="dragDropCont" class="btn btnMenu">SIMPLE MODE</div>
                <div class="dragDropMenu menuWorkflow">
                    <div class="titleCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Title</div>
                        <input type="text" class="inputText col-md-12 noPadding titleVal" />
                    </div>
                    <div class="typeCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Type</div>
                        <select class="col-md-12 noPadding ddl ddlType">
                            <option value="operation">Operation</option>
                            <option value="condition">Condition</option>
                        </select>
                    </div>
                    <div class="trueCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">True Case Redirection</div>
                        <select class="col-md-12 noPadding ddl ddlTrueRedirect">

                        </select>
                    </div>
                    <div class="falseCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">False Case Redicrection</div>
                        <select class="col-md-12 noPadding ddl ddlFalseRedirect">

                        </select> 
                    </div>
                    <div class="insertBeforeCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Insert</div>
                        <span class="radTtl"><input type="radio" name="radInsert" value="After" class="inputRadio" checked="checked"/>After</span>
                        <span class="radTtl"><input type="radio" name="radInsert" value="Before" class="inputRadio"/>Before</span>
                        <select class="col-md-12 noPadding ddl ddlInsert">

                        </select>
                    </div>
                    <div class="descriptionCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Description</div>
                        <textarea class="description inputTextArea descriptionVal">
                                    
                        </textarea>
                    </div>
                    <div class="emailCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Assigned Email (Seperated By ';')</div>
                        <textarea class="email inputTextArea emailVal">
                                    
                        </textarea>
                    </div>
                    <div class="startDateCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">Start Date</div>
                        <div class="btn btnStartDate">Choose</div>
                        <span class="chosenStartDate"></span>
                    </div>
                    <div class="endDateCont row noMargin cont">
                        <div class="col-md-12 noPadding ttl">End Date</div>
                        <div class="btn btnEndDate">Choose</div>
                        <span class="chosenEndDate"></span>
                    </div>
                    <div class="btn btnAdd" id="btnAdd">ADD TO WORKFLOW</div>
                    <div class="clear"></div>
                    <label for="btnAdd" id="lblBtnAdd"></label>
                </div>
                <div class="clear"></div>
                <div id="manualCont" class="btn btnMenu">ADVANCED MODE</div>
                <div class="manualMenu menuWorkflow">
                    <textarea id="manualFlowChart"></textarea>
                    <div class="clear"></div>
                    <div class="btn btnRender">RENDER WORKFLOW</div>
                </div>

                <div class="btn btnSaveWorkflow" id="btnSaveWorkflow" value="Save" style="float: right;">Save</div>
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
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Title</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask popupTtl"  /></div>
                </div>
                <div class="row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Type</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding">
                        <select class="col-md-12 noPadding ddl popupDdlType">
                            <option value="operation">Operation</option>
                            <option value="condition">Condition</option>
                        </select>
                    </div>
                </div>
                <div class="popupTrueCont row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">True Case Redirection</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding">
                        <select class="col-md-12 noPadding ddl popupDdlTrueRedirect">

                        </select>
                    </div>
                </div>
                <div class="popupFalseCont row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">False Case Redicrection</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding">
                        <select class="col-md-12 noPadding ddl popupDdlFalseRedirect">

                        </select> 
                    </div>
                </div>
                <div class="popupInsertBeforeCont row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Insert</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding">
                        <span class="radTtl"><input type="radio" name="popupRadInsert" value="After" class="inputRadio" checked="checked"/>After</span>
                        <span class="radTtl"><input type="radio" name="popupRadInsert" value="Before" class="inputRadio"/>Before</span>
                    </div>
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding">
                        <select class="col-md-12 noPadding ddl popupDdlInsert">

                        </select>
                    </div>

                </div>
                <div class="row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Description</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask popupDescriptionVal" /></div>
                </div>
                <div class="row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Email</label></div>
                    <div class="col-md-9 col-sm-7 col-xs-7 noPadding"><input type="text" class="inputTask popupEmailVal" /></div>
                </div>
                <div class="popupStartDateCont row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">Start Date</label></div>
                    <div class="col-md-1 col-sm-1 col-xs-1 noPadding"><div class="btn popupBtnStartDate">Choose</div></div>
                    <div class="col-md-8 col-sm-6 col-xs-6 noPadding"><span class="popupChosenStartDate"></span></div>
                </div>
                <div class="popupEndDateCont row noMargin taskRow">
                    <div class="col-md-3 col-sm-5 col-xs-5 noPadding"><label class="inputTitle">End Date</label></div>
                    <div class="col-md-1 col-sm-1 col-xs-1 noPadding"><div class="btn popupBtnEndDate">Choose</div></div>
                    <div class="col-md-8 col-sm-6 col-xs-6 noPadding"><span class="popupChosenEndDate"></span></div>
                </div>
                <div class="row noMargin taskRow">
                    <div class="col-md-12 col-sm-12 col-xs-12 noPadding">
                        <div class="btn btnDelete">DELETE</div>
                        <div class="btn btnSave" id="btnSave">UPDATE</div>
                        <div class="clear"></div>
                        <label for="btnSave" id="lblBtnSave"></label>
                    </div>
                </div>
            </div>
        </div>


        <script  language="javascript">
            var workflowId = -2;
            var userName = '<%= session.getAttribute("userName")%>';
            $(document).ready(function () {

            });

            function onLoad() {
                gapi.load('auth2', function () {
                    gapi.auth2.init();
                });
            }

            function signOut() {
                window.location.href = "https://accounts.google.com/Logout";
                //window.location.pathname = 'google-oauth-example/index.jsp';
            }
            function home(){
                window.location.href = 'editWorkFlow.jsp';
            }
        </script>
    </body>
</html>
