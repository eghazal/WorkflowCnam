var workflowTasks = [];
var operationsCount = 1;
var conditionsCount = 1;
var workflowStr = "";
//var apiURL = "http://localhost:9999";
var apiURL="https://workflowapi-176706.appspot.com";
$(document).ready(function () {

    if (parseInt($("#workflowId").val()) > 0) {
        loadWorkflowTasks();
    } else {
        if (workflowTasks.length == 0) {
            createStartEnd();
            createWorkflowStr();
            renderWorkflow();
        } else {
            $('#manualFlowChart').html($('.flowchart').html());
            renderWorkflow();
        }
    }


    if (workflowTasks.length == 0) {
        createStartEnd();
        createWorkflowStr();
        renderWorkflow();
    } else {
        $('#manualFlowChart').html($('.flowchart').html());
        renderWorkflow();
    }

    $(".btnRender").on("click", function () {
        renderWorkflow();
    });

    $(".btnMenu").on("click", function () {
        if ($(this).attr('id') == 'dragDropCont') {
            $(".menuWorkflow").not($(".dragDropMenu")).slideUp();
            $(".dragDropMenu").slideToggle();
        } else {
            if ($(this).attr('id') == 'manualCont') {
                $(".menuWorkflow").not($(".manualMenu")).slideUp();
                $(".manualMenu").slideToggle();
            }
        }
    });

    $("body").on("click", ".task, .end-element", function () {
        var task = $(this);
        var taskObj = {};
        if ($(this).prop("classList").toString().indexOf("task") > -1) {
            if ($(".task").length > 0) {
                for (var taskCount = 0; taskCount <= $(".task").length - 1; taskCount++) {
                    if ($(this).is($($(".task")[taskCount]))) {
                        taskObj = workflowTasks[taskCount];
                        continue;
                    }
                }
            }

        } else
            taskObj = workflowTasks[workflowTasks.length - 1];

        //CLEAR INPUTS
        $(".taskPopupCont .inputText").val("");
        $('.taskPopupCont .popupBtnStartDate').datetimepicker('reset');
        $('.taskPopupCont .popupBtnEndDate').datetimepicker('reset');
        $('.taskPopupCont .popupChosenStartDate').html("");
        $('.taskPopupCont .popupChosenEndDate').html("");
        $($(".taskPopupCont input[name='popupRadInsert']")[0]).prop("checked", "checked");

        //SET INPUTS
        $(".popupTtl").val(taskObj.title);
        $(".popupDdlType").val(taskObj.type);
        $(".popupDdlTrueRedirect").val(taskObj.trueRedirect);
        $(".popupDdlFalseRedirect").val(taskObj.falseRedirect);
        $(".popupDescriptionVal").val(taskObj.description);
        $(".popupEmailVal").val(taskObj.email);
        $(".popupEmailVal").val(taskObj.email);
        $(".popupBtnStartDate").datetimepicker('reset');
        $(".popupBtnStartDate").datetimepicker({
            minDate: new Date(Date.now()),
            value: new Date(taskObj.startDate)
        });
        $(".popupChosenStartDate").html(formatDateStr(taskObj.startDate));
        $(".popupBtnEndDate").datetimepicker({
            minDate: new Date(taskObj.startDate),
            value: new Date(taskObj.endDate)
        });
        $(".popupChosenEndDate").html(formatDateStr(taskObj.endDate));

        if (taskObj.type == "condition") {
            $(".popupTrueCont").show();
            $(".popupFalseCont").show();
        } else {
            $(".popupTrueCont").hide();
            $(".popupFalseCont").hide();
        }

        $('#taskPopup').attr("taskGraphIndex", taskObj.taskGraphIndex).bPopup({
            closeClass: 'closeModule',
            modalClose: false,
            opacity: 0.6,
            positionStyle: 'fixed',
            zIndex: 9996
        });
    });

    $(".ddlType").on("change", function () {
        var selectedOp = $(this).val();
        switch (selectedOp.toLowerCase()) {
            case "operation":
                $(".trueCont").hide();
                $(".falseCont").hide();
                break;

            case "condition":
                $(".trueCont").show();
                $(".falseCont").show();
                break;
        }
    });

    $(".popupDdlType").on("change", function () {
        var selectedOp = $(this).val();
        switch (selectedOp.toLowerCase()) {
            case "operation":
                $(".popupTrueCont").hide();
                $(".popupFalseCont").hide();
                break;

            case "condition":
                $(".popupTrueCont").show();
                $(".popupFalseCont").show();
                break;
        }
    });

    $(".btnStartDate").datetimepicker({minDate: Date.now(),
        onGenerate: function () {
            $(this).attr('id', "startingDate")
        },
        onSelectDate: function (dataD) {
            $('.chosenStartDate').html(formatDateStr(dataD));
            $(".btnEndDate").datetimepicker({
                minDate: ($('.btnStartDate').datetimepicker('getValue') != null) ? $('.btnStartDate').datetimepicker('getValue') : Date.now()
            });
        },
        onSelectTime: function (dataD) {
            $('.chosenStartDate').html(formatDateStr(dataD));
            $(".btnEndDate").datetimepicker({
                minDate: ($('.btnStartDate').datetimepicker('getValue') != null) ? $('.btnStartDate').datetimepicker('getValue') : Date.now()
            });
        }
    });

    $(".btnEndDate").datetimepicker({
        minDate: ($('.btnStartDate').datetimepicker('getValue') != null) ? $('.btnStartDate').datetimepicker('getValue') : Date.now(),
        onGenerate: function () {
            $(this).attr('id', "endDate")
        },
        onSelectDate: function (dataD) {
            $('.chosenEndDate').html(formatDateStr(dataD));
        },
        onSelectTime: function (dataD) {
            $('.chosenEndDate').html(formatDateStr(dataD));
        }
    });

    $(".popupBtnStartDate").datetimepicker({minDate: Date.now(),
        onGenerate: function () {
            $(this).attr('id', "popupStartingDate")
        },
        onSelectDate: function (dataD) {
            $('.popupChosenStartDate').html(formatDateStr(dataD));
            $(".popupBtnEndDate").datetimepicker({
                minDate: ($('.popupBtnStartDate').datetimepicker('getValue') != null) ? $('.popupBtnStartDate').datetimepicker('getValue') : Date.now()
            });
        },
        onSelectTime: function (dataD) {
            $('.popupChosenStartDate').html(formatDateStr(dataD));
            $(".popupBtnEndDate").datetimepicker({
                minDate: ($('.popupBtnStartDate').datetimepicker('getValue') != null) ? $('.popupBtnStartDate').datetimepicker('getValue') : Date.now()
            });
        }
    });

    $(".popupBtnEndDate").datetimepicker({
        minDate: ($('.popupBtnStartDate').datetimepicker('getValue') != null) ? $('.popupBtnStartDate').datetimepicker('getValue') : Date.now(),
        onGenerate: function () {
            $(this).attr('id', "popupEndDate")
        },
        onSelectDate: function (dataD) {
            $('.popupChosenEndDate').html(formatDateStr(dataD));
        },
        onSelectTime: function (dataD) {
            $('.popupChosenEndDate').html(formatDateStr(dataD));
        }
    });

    $(".btnAdd, .btnSave").on("click", function () {
        addTask($(this));
    });

    $(".btnDelete").on("click", function () {
        removeTask();
    });

    $(".btnSaveWorkflow").on("click", function () {
        saveWorkflow1();
    });
});

function renderWorkflow() {
    $('.flowchart svg').remove();
    $('.flowchart').html($('#manualFlowChart').val());
    renderFunction();
}

function renderFunction() {
    $(".flowchart").flowChart({
        "line-color": "#E91E63",
        "element-color": "#263238",
        "symbols": {
            "start": {
                "element-color": "#E91E63",
                "fill": "#E91E63"
            }
        }
    });
}


function formatDateStr(dateStr) {
    var d = new Date(dateStr);
    var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    var hour = d.getHours();
    var minute = d.getMinutes();
    var second = d.getSeconds();
    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }
    if (hour < 10) {
        hour = "0" + hour;
    }
    if (minute < 10) {
        minute = "0" + minute;
    }
    if (second < 10) {
        second = "0" + second;
    }
    var date = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + second;
    return date;
}


function addTask(elementClicked) {
    //VALIDATE TASK BEFORE ADD

    var elementId = $(elementClicked).attr("id");
    switch (elementId.toLowerCase()) {
        case "btnadd":
            var canAdd = true;
            var msg = "";

            if ($('.btnStartDate').datetimepicker('getValue') > $('.btnEndDate').datetimepicker('getValue')) {
                canAdd = false;
                msg = "Start date should be less than end date";
            }

            if ($('.btnEndDate').datetimepicker('getValue') == "null" || $('.btnEndDate').datetimepicker('getValue') == undefined) {
                canAdd = false;
                msg = "Please choose end date";
            }

            if ($('.btnStartDate').datetimepicker('getValue') == "null" || $('.btnStartDate').datetimepicker('getValue') == undefined) {
                canAdd = false;
                msg = "Please choose starting date";
            }

            var emailArray = $(".emailVal").val().split(";");
            $.each(emailArray, function (i) {
                if (!validateEmail(emailArray[i])) {
                    canAdd = false;
                    msg = "Please enter valid email";
                }
            });

            if ($(".ddlType").val() == "condition") {
                if ($(".ddlTrueRedirect").val() == $(".ddlFalseRedirect").val()) {
                    canAdd = false;
                    msg = "Please choose different redirections";
                }
            }

            if ($(".titleVal").val() == "" || $(".titleVal").val() == " " || $(".titleVal").val().length == 0) {
                canAdd = false;
                msg = "Please enter task title";
            }

            if (canAdd) {
                $("#lblBtnAdd").html("");
                //ADDING TASK TO OBJ
                var tag = "";
                if ($(".ddlType").val() == "condition") {
                    tag = "cond" + conditionsCount;
                    conditionsCount++;
                } else {
                    if ($(".ddlType").val() == "operation") {
                        tag = "op" + operationsCount;
                        operationsCount++;
                    }
                }
                var task = {
                    "taskId": "0",
                    "taskGraphIndex": workflowTasks.length,
                    "tag": tag,
                    "title": $(".titleVal").val(),
                    "type": $(".ddlType").val(),
                    "trueRedirect": ($(".ddlType").val() == "condition") ? $(".ddlTrueRedirect").val() : "",
                    "falseRedirect": ($(".ddlType").val() == "condition") ? $(".ddlFalseRedirect").val() : "",
                    "description": $(".descriptionVal").val(),
                    "email": $(".emailVal").val(),
                    "startDate": $('.btnStartDate').datetimepicker('getValue'),
                    "endDate": $('.btnEndDate').datetimepicker('getValue')
                }

                //ADDING TASK TO ARRAYLIST
                var positionType = "after";
                if ($("input[name='radInsert']:checked").val().toLowerCase() == "before") {
                    positionType = "before";
                }

                var internalIndex = 0;
                if ($(".ddlInsert").val() != "" && $(".ddlInsert").val() != undefined && parseInt($(".ddlInsert").val()) >= 0)
                    internalIndex = $(".ddlInsert").val();

                var positionIndex = 0;
                $.each(workflowTasks, function (i) {
                    if (workflowTasks[i].taskGraphIndex == internalIndex) {
                        positionIndex = i;
                        return false;
                    }
                });

                if (positionType == "after") {
                    positionIndex++;
                } else {
                    if (positionType == "before" && positionIndex == 0) {
                        positionIndex++;
                    }
                }

                workflowTasks.splice(positionIndex, 0, task);
                //getObjects(workflowTasks, "taskGraphIndex", positionIndex);
                //workflowTasks.push(task);

                //CLEAR INPUTS
                $(".dragDropMenu .inputText").val("");
                $(".dragDropMenu .inputTextArea").val("");
                $('.dragDropMenu .btnStartDate').datetimepicker('reset');
                $('.dragDropMenu .btnEndDate').datetimepicker('reset');
                $('.dragDropMenu .chosenStartDate').html("");
                $('.dragDropMenu .chosenEndDate').html("");
                $($(".dragDropMenu input[name='radInsert']")[0]).prop("checked", "checked");
            } else {
                $("#lblBtnAdd").html(msg);
            }

            break;

        case "btnsave":
            var canAdd = true;
            var msg = "";

            if ($('.popupBtnStartDate').datetimepicker('getValue') > $('.popupBtnEndDate').datetimepicker('getValue')) {
                canAdd = false;
                msg = "Start date should be less than end date";
            }

            if ($('.popupBtnEndDate').datetimepicker('getValue') == "null" || $('.popupBtnEndDate').datetimepicker('getValue') == undefined) {
                canAdd = false;
                msg = "Please choose end date";
            }

            if ($('.popupBtnStartDate').datetimepicker('getValue') == "null" || $('.popupBtnStartDate').datetimepicker('getValue') == undefined) {
                canAdd = false;
                msg = "Please choose starting date";
            }

            var emailArray = $(".popupEmailVal").val().split(";");
            $.each(emailArray, function (i) {
                if (!validateEmail(emailArray[i])) {
                    canAdd = false;
                    msg = "Please enter valid email";
                }
            });

            if ($(".popupDdlType").val() == "condition") {
                if ($(".popupDdlTrueRedirect").val() == $(".popupDdlFalseRedirect").val()) {
                    canAdd = false;
                    msg = "Please choose different redirections";
                }
            }

            if ($(".popupTtl").val() == "" || $(".popupTtl").val() == " " || $(".popupTtl").val().length == 0) {
                canAdd = false;
                msg = "Please enter task title";
            }

            if (canAdd) {
                $("#lblBtnSave").html("");
                //ADDING TASK TO OBJ
                var curTask = {};

                var indexOfTask = -1;
                $.each(workflowTasks, function (i) {
                    if (workflowTasks[i]["taskGraphIndex"] == $($(elementClicked).closest("#taskPopup")).attr("taskgraphindex")) {
                        curTask = workflowTasks[i];
                        indexOfTask = i;
                    }
                });
                workflowTasks.splice(indexOfTask, 1);

                curTask.title = $(".popupTtl").val();
                curTask.type = $(".popupDdlType").val();
                curTask.trueRedirect = ($(".popupDdlType").val() == "condition") ? $(".popupDdlTrueRedirect").val() : "";
                curTask.falseRedirect = ($(".popupDdlType").val() == "condition") ? $(".popupDdlFalseRedirect").val() : "";
                curTask.description = $(".popupDescriptionVal").val();
                curTask.email = $(".popupEmailVal").val();
                curTask.startDate = $('.popupBtnStartDate').datetimepicker('getValue');
                curTask.endDate = $('.popupBtnEndDate').datetimepicker('getValue');


                //ADDING TASK TO ARRAYLIST
                var positionType = "after";
                if ($("input[name='popupRadInsert']:checked").val().toLowerCase() == "before") {
                    positionType = "before";
                }

                var internalIndex = 0;
                if ($(".popupDdlInsert").val() != "" && $(".popupDdlInsert").val() != undefined && parseInt($(".popupDdlInsert").val()) >= 0)
                    internalIndex = $(".popupDdlInsert").val();

                var positionIndex = 0;
                $.each(workflowTasks, function (i) {
                    if (workflowTasks[i].taskGraphIndex == internalIndex) {
                        positionIndex = i;
                        return false;
                    }
                });

                if (positionType == "after") {
                    positionIndex++;
                } else {
                    if (positionType == "before" && positionIndex == 0) {
                        positionIndex++;
                    }
                }

                workflowTasks.splice(positionIndex, 0, curTask);

                //CLEAR INPUTS
                $(".inputTask").val("");
                $('.popupBtnStartDate').datetimepicker('reset');
                $('.popupBtnEndDate').datetimepicker('reset');
                $('.popupChosenStartDate').html("");
                $('.popupChosenEndDate').html("");
                $($("input[name='popupRadInsert']")[0]).prop("checked", "checked");
                $("#taskPopup").bPopup().close();
            } else {
                $("#lblBtnSave").html(msg);
            }
            break;
    }


    //UPDATE LISTS IN SIMPLE MODE
    updateLists();

    //RENDER WORKFLOW
    createWorkflowStr();
    renderWorkflow();
}

function createStartEnd() {
    var startTask = {
        "taskId": "0",
        "taskGraphIndex": 0,
        "tag": "st",
        "title": "Start",
        "type": "operation",
        "trueRedirect": "",
        "falseRedirect": "",
        "description": "",
        "email": "",
        "startDate": "",
        "endDate": ""
    }

    workflowTasks.push(startTask);

    var endTask = {
        "taskId": "0",
        "taskGraphIndex": 1,
        "tag": "e",
        "title": "End",
        "type": "operation",
        "trueRedirect": "",
        "falseRedirect": "",
        "description": "",
        "email": "",
        "startDate": "",
        "endDate": ""
    }

    workflowTasks.push(endTask);
}

function updateLists() {
    $(".ddlTrueRedirect").html("");
    $(".ddlFalseRedirect").html("");
    $(".ddlInsert").html("");
    $(".popupDdlTrueRedirect").html("");
    $(".popupDdlFalseRedirect").html("");
    $(".popupDdlInsert").html("");

    $.each(workflowTasks, function (i) {
        if (i != 0 && i != (workflowTasks.length - 1)) {
            $(".ddlTrueRedirect").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
            $(".ddlFalseRedirect").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
            $(".ddlInsert").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
            $(".popupDdlTrueRedirect").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
            $(".popupDdlFalseRedirect").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
            $(".popupDdlInsert").append("<option value=" + workflowTasks[i].taskGraphIndex + ">" + workflowTasks[i].title + "</option>");
        }

    });

    var endTask = getObjects(workflowTasks, "tag", "e");
    $(".ddlTrueRedirect").append("<option value=" + endTask[0].taskGraphIndex + " >" + endTask[0].title + "</option>");
    $(".ddlFalseRedirect").append("<option value=" + endTask[0].taskGraphIndex + " >" + endTask[0].title + "</option>");
    $(".popupDdlTrueRedirect").append("<option value=" + endTask[0].taskGraphIndex + " >" + endTask[0].title + "</option>");
    $(".popupDdlFalseRedirect").append("<option value=" + endTask[0].taskGraphIndex + " >" + endTask[0].title + "</option>");
}

function createWorkflowStr() {
    workflowStr = "";
    var workflowSchema = "";
    var workflowConditions = "";
    $.each(workflowTasks, function (i) {

        //DEFINITION OF ALL TASKS + CREATION OF THE SCHEMA OF TASKS 
        if (i == 0) {
            workflowStr += "st=>start: " + workflowTasks[i].title + "\n";
            workflowSchema += "st";
        } else {
            if (i == (workflowTasks.length - 1)) {
                workflowStr += "e=>end: " + workflowTasks[i].title + "\n";
                workflowSchema += "->e" + "\n";
            } else {
                switch (workflowTasks[i].type.toLowerCase()) {
                    case "operation":
                        workflowStr += workflowTasks[i].tag + "=>operation: " + workflowTasks[i].title + "\n";
                        workflowSchema += "->" + workflowTasks[i].tag;

                        break;

                    case "condition":
                        workflowStr += workflowTasks[i].tag + "=>condition: " + workflowTasks[i].title + "\n";
                        workflowSchema += "->" + workflowTasks[i].tag;

                        //CREATION OF CONDITIONS + REDIRECTIONS
                        //GET OBJECT OF REDIRECTED TASK INDEX
                        var falseCaseObj = getObjects(workflowTasks, "taskGraphIndex", workflowTasks[i].falseRedirect)
                        workflowConditions += workflowTasks[i].tag + "(no)->" + falseCaseObj[0].tag + "\n";

                        //GET OBJECT OF REDIRECTED TASK INDEX
                        var trueCaseObj = getObjects(workflowTasks, "taskGraphIndex", workflowTasks[i].trueRedirect)
                        workflowConditions += workflowTasks[i].tag + "(yes)->" + trueCaseObj[0].tag + "\n";
                        break;
                }
            }
        }

    });
    workflowStr += workflowSchema;
    workflowStr += workflowConditions;
    document.getElementById("manualFlowChart").value = workflowStr;
}

function removeTask() {
    var taskGraphIndex = $("#taskPopup").attr("taskgraphindex");
    //REMOVING TASK FROM ARRAY
    var indexOfTask = -1;
    $.each(workflowTasks, function (i) {
        if (workflowTasks[i]["taskGraphIndex"] == taskGraphIndex) {
            indexOfTask = i;
        }
    });

    workflowTasks.splice(indexOfTask, 1);

    //REMOVING REDIRECTION LINK TO THE DELETED TASK
    $.each(workflowTasks, function (i) {
        if (workflowTasks[i]["falseRedirect"] == taskGraphIndex) {
            workflowTasks[i]["falseRedirect"] = "";
        }

        if (workflowTasks[i]["trueRedirect"] == taskGraphIndex) {
            workflowTasks[i]["trueRedirect"] = "";
        }
    });

    //UPDATING LISTS
    updateLists();
    createWorkflowStr();
    renderWorkflow();
    $("#taskPopup").attr("taskgraphindex", "");
    $("#taskPopup").bPopup().close();
}

function getObjects(obj, key, val) {
    var objects = [];
    for (var i in obj) {
        if (!obj.hasOwnProperty(i))
            continue;
        if (typeof obj[i] == 'object') {
            objects = objects.concat(getObjects(obj[i], key, val));
        } else if (i == key && obj[key] == val) {
            objects.push(obj);
        }
    }
    return objects;
}


function getFromAPI() {
    //https://workflowapi-176706.appspot.com
    $.getJSON(apiURL + '/GetUsers?callback=?',
            function (data) {
                console.log(data);
            });
}

function saveWorkflow() {
    //https://jsonplaceholder.typicode.com/posts/1
    //http://localhost:8080/GetUsers
    console.log(JSON.stringify(workflowTasks));
    console.log(userName);
    console.log(workflowId);
    $.ajax({
        crossDomain: true,
        url: apiURL + '/UpsertWorkflow',
        type: 'POST',
        crossDomain: true,
        data: {
            workflowObj: JSON.stringify(workflowTasks),
            userName: userName,
            workFlowId: workflowId

        },
        dataType: "jsonp",
        success: function (data) {
            console.log(data);
        }
    });
}

function saveWorkflow1() {
    console.log(JSON.stringify(workflowTasks));
    var workflowDesc = document.getElementById("wfDesc").value;
    return $.ajax({
        url: "http://query.yahooapis.com/v1/public/yql",
        // the name of the callback parameter, as specified by the YQL service
        jsonp: "callback",
        // tell jQuery we're expecting JSONP
        dataType: "jsonp",
        // tell YQL what we want and that we want JSON
        data: {
            q: "select * from json where " +
                    +"url=" + apiURL + "/UpsertWorkflow",
            type: 'POST',
            workflowObj: JSON.stringify(workflowTasks),
            userName: userName,
            workFlowId: workflowId,
            workflowDesc: workflowDesc,
            crossDomain: true,
            format: "json"
        },
        // work with the response
        success: function (response) {
            return true;
        },
        error : function(error){
            alert(error);
        }
    });
}

function validateEmail(sEmail) {
    var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    if (filter.test(sEmail)) {
        return true;
    } else {
        return false;
    }
}
function loadWorkflowTasks() {
    $.ajax({
        crossDomain: true,
        url: apiURL + '/loadWorkflow',
        type: 'get',
        data: {workflowId: $("#workflowId").val()},
        dataType: "jsonp",
        success: function (data) {
            var loadedObj = JSON.parse(data);
            if (loadedObj.workflowObj != "[]") {
                workflowTasks = loadedObj.workflowObj;
            }
        },
        error: function (error) {
            console.log(error);
        }

    });
}