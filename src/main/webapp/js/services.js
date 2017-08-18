/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

getAllUsers=new function(){
         $.ajax({
    url: "http://query.yahooapis.com/v1/public/yql",

    // the name of the callback parameter, as specified by the YQL service
    jsonp: "callback",

    // tell jQuery we're expecting JSONP
    dataType: "jsonp",

    // tell YQL what we want and that we want JSON
    data: {
        q: "select * from json where url=\"https://workflowapi-176706.appspot.com/GetUsers?format=json\"",
        format: "json"
    },

    // work with the response
    success: function( response ) {
        return response.query.results.json; // server response
    }
    });
    }
