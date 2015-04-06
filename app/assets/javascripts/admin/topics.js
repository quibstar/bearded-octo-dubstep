var toManyLines;
var editMode = 0;

// set up counter to be used in multiple functions
var counterOneContainer;
var counterTwoContainer;
var counterThreeContainer;
var counterOne;
var counterTwo;
var counterThree;

$(document).ready(function() {

	// Goolgle 25/35/35
	// Twitter 140
	// FB ad 25/90
	//      post unlimited
	// LinedIn 25/75
	
	$("#edit-mode").click(function(e){
		if(editMode == 0) {
			$("#form-remote .widget-header .btn, #form-remote .widget-content .btn, #form-remote .widget-content .btn-u").fadeIn();
			editMode = 1
			$(this).html("Preview Mode");
		} else {
			$("#form-remote .widget-header .btn, #form-remote .widget-content .btn, #form-remote .widget-content .btn-u").fadeOut();
			editMode = 0
			$(this).html("Edit Mode");
		}
	});


	$("#review-mode").click(function(e){
		if(editMode == 1) {
			$("#form-remote .widget-header .btn, #form-remote .widget-content .btn, #form-remote .widget-content .btn-u").fadeIn();
			editMode = 0
			$(this).html("Preview Mode");
		} else {
			$("#form-remote .widget-header .btn, #form-remote .widget-content .btn, #form-remote .widget-content .btn-u").fadeOut();
			editMode = 1
			$(this).html("Edit Mode");
		}
	});



	$(".new-copy").click(function(e){
		e.preventDefault();
		var ta = $(this).data("textarea");
		var net = $(this).data("network");
		currentTextArea($(this), ta, net);

		$(".front-form").hide();
	});

	$(".edit-copy").click(function(e){
		e.preventDefault();
		var ta = $(this).data("textarea");
		var net = $(this).data("network");
		currentTextArea($(this),ta, net);

	});

	$(".dup-copy").click(function(e){
		e.preventDefault();
		var ta = $(this).data("textarea");
		var net = $(this).data("network");
		var target = $(this).data("target");
		var targetVal = $("#"+target).text();
		var n = targetVal.split("\n");
		var newLine = '';

		for(var x in n){ 
			if(n[x].length > 0) {
				newLine = newLine + $.trim(n[x]);
				newLine = newLine + "\n";
			}
			
		}
		$("#"+ta).val(newLine);
		currentTextArea($(this),ta, net);

		var closestForm = $(this).closest(".copy-content").find(".front-form");
		if(closestForm.is(":visible")) {
			$(".front-form").hide();			
		} else {
			$(".front-form").hide();
			closestForm.show();

		}
	});

	$(".cancel-new").live("click",function(e){
		e.preventDefault();
		 $.fancybox.close( true ); 
	});

	$(".cancel-new-front").live("click",function(e){
		e.preventDefault();
		$(".front-form").hide();
	});

	$(".send-to").live("click",function(e){
		e.preventDefault();
		$("#send-to").fadeToggle();
	});

});

function hideAll() {
	$(".btn-group, .edit-topic, .new-group").hide();
}

function showAll() {
	$(".btn-group, .edit-topic, .new-group").show();
}
	
function currentTextArea(element, textAreaID, network) {

	var currentTA = $("#" + textAreaID);
	toManyLines = element.closest("form").find($(".to-many-lines"));
	currentTA.live('keyup', function() {

		var str = $(this).val();

		if(str == 0) {
			clearAllCounters();
		}

		adjustCounters(str, network)

	});

	// this will be used more for new copy
	currentTA.live("focus", function(e) { // Select the radio input group
    	p = $(this).closest("li");
    	counterOneContainer = p.find($(".counter-one-container"));
		counterTwoContainer = p.find($(".counter-two-container"));
		counterThreeContainer = p.find($(".counter-three-container"));

		counterOne = p.find($(".count-one"));
		counterTwo = p.find($(".count-two"));
		counterThree = p.find($(".count-three"));

		clearAllCounters();

		
		adjustCounterBasedOnNetwork(network);

		var str = $(this).val();
		if(str) {
			adjustCounters(str, network)
		}

    	// reset to many line on new form
    	toManyLines = $(this).closest("form").find($(".to-many-lines"));
	});
	
}


function adjustCounterBasedOnNetwork(net) {
	if(net == "Google") {
		counterOneContainer.show();
		counterTwoContainer.show();
		counterThreeContainer.show();

	}

	if(net == "Twitter") {
		counterOneContainer.show();
		counterTwoContainer.hide();
		counterThreeContainer.hide();
	}

	if(net == "FaceBook Ad") {
		counterOneContainer.show();
		counterTwoContainer.show();
		counterThreeContainer.hide();
	}

	if(net == "FaceBook Post") {
		counterOneContainer.hide();
		counterTwoContainer.hide();
		counterThreeContainer.hide();
	}

	if(net == "LinkedIn") {
		counterOneContainer.show();
		counterTwoContainer.show();
		counterThreeContainer.hide();
	}
}

function adjustCounters(str, network){

	if(network == "Google") {
		googleCharCheck(str);
	} else if (network == "Twitter") {
		twitterCharCheck(str);
	} else if (network == "FaceBook Ad") {
		fbAdCharCheck(str);
	} else if (network == "FaceBook Post") {
		// 
	} else if (network == "LinkedIn") {
		linkedInCharChecker(str);
	}
}

function clearAllCounters() {
	counterOne.html("");
	counterTwo.html("");
	counterThree.html("");
}

function checkCharacterCount(element, charCount, maxCharCount){
	if(charCount > maxCharCount) {
		element.addClass("counter-error");
	} else {
		element.removeClass("counter-error");
	}
}

function googleCharCheck(str) {
	var n = str.split("\n");
	for(var x in n){   
	    
	    if(n[0] && n[0].length > 0) {
	    	var charCount = n[0].length;
	    	counterOne.html(charCount);
	    	checkCharacterCount(counterOne, charCount, 25);
	    } else {
	    	counterTwo.html('')
	    }
	    

	    if(n[1] && n[1].length > 0) {
	    	var charCount = n[1].length;
	    	counterTwo.html(n[1].length);
	    	checkCharacterCount(counterTwo, charCount, 35);
	    } else {
	    	counterTwo.html('')
	    }

	    if(n[2] && n[2].length > 0) {
	    	var charCount = n[2].length;
	    	counterThree.html(n[2].length);
	    	checkCharacterCount(counterThree, charCount, 35);
	    } else {
	    	counterThree.html('')
	    }

	    if(n[3]) {
	    	toManyLines.show();
	    } else {
	    	toManyLines.hide();
	    }
	}
}

function twitterCharCheck(str) {
	// if character count greater than 140
	var charCount = str.length;
	counterOne.html(charCount);
	checkCharacterCount(counterOne, charCount, 140);
}

function fbAdCharCheck(str) {
	var n = str.split("\n");
	for(var x in n){   
	    
	    if(n[0] && n[0].length > 0) {
	    	var charCount = n[0].length;
	    	counterOne.html(charCount);
	    	checkCharacterCount(counterOne, charCount, 25);
	    }
	    

	    if(n[1] && n[1].length > 0) {
	    	var charCount = n[1].length;
	    	counterTwo.html(n[1].length);
	    	checkCharacterCount(counterTwo, charCount, 90);
	    }

	    if(n[2]) {
	    	toManyLines.show();
	    } else {
	    	toManyLines.hide();
	    }  
	}
}

function fbPostCharChecker() {
}

function linkedInCharChecker(str) {
	var n = str.split("\n");
	for(var x in n){   
	    
	    if(n[0] && n[0].length > 0) {
	    	var charCount = n[0].length;
	    	counterOne.html(charCount);
	    	checkCharacterCount(counterOne, charCount, 25);
	    }
	    

	    if(n[1] && n[1].length > 0) {
	    	var charCount = n[1].length;
	    	counterTwo.html(n[1].length);
	    	checkCharacterCount(counterTwo, charCount, 75);
	    } 

	    if(n[2]) {
	    	toManyLines.show();
	    } else {
	    	toManyLines.hide();
	    } 
	}
}