$(function() {
	$("#notice").on('click', function() {
		hideSlidingMessage();
	});

	// press ESCAPE key to hide the message
	$(document).keydown(function(e) {
    if (e.keyCode == 27) { 
      hideSlidingMessage();
    }
	});

});

function showMessage(message){
	$("#dialog").html(message).dialog();
}

function hideSlidingMessage(){
	$("#notice").stop().slideUp();
}

function showSlidingMessage(message, className){
	$("#notice").removeClass().addClass(className).html(message);
	$("#notice").slideDown().delay(10000).slideUp();
}

function showSuccessMessage(message){
	showSlidingMessage(message, 'success');
}

function showErrorMessage(message){
	showSlidingMessage(message, 'error');
}