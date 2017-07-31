$(document).ready(function() {
	$('#manualFlowChart').html($('.flowchart').html());
	renderFunction();
	
	$(".btnRender").on("click", function(){
		renderWorkflow();
	});

	$(".btnMenu").on("click", function(){
		if($(this).attr('id') == 'dragDropCont'){
			$(".menuWorkflow").not($(".dragDropMenu")).slideUp();
			$(".dragDropMenu").slideToggle();
		}else{
			if($(this).attr('id') == 'manualCont'){
				$(".menuWorkflow").not($(".manualMenu")).slideUp();
				$(".manualMenu").slideToggle();
			}
		}
	});
	
	$("body").on("click", ".task, .end-element", function(){
		$('#taskPopup').bPopup({
			closeClass:'closeModule',
			modalClose: false,
			opacity: 0.6,
			positionStyle: 'fixed' 
		});
	});
	
});

function renderWorkflow(){
	$('.flowchart svg').remove();
	$('.flowchart').html($('#manualFlowChart').val());
	renderFunction();
}

function renderFunction(){
	$(".flowchart").flowChart({
		"line-color"    : "#E91E63",
		"element-color" : "#263238",
		"symbols"       : {
			"start"     : {
				"element-color" : "#E91E63",
				"fill"          : "#E91E63"
			}
		},
	});
}