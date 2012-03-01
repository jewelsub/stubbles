$(function() {
	$("#dialog").hide();
	$("#notice").hide().on('click', function() {
		$(this).stop().slideUp();
	});
});

function showMessage(message){
	$("#dialog").html(message).dialog();
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