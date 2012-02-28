function showMessage(message){
	$("#dialog").html(message).dialog();
}

function showSlidingMessage(message, className){
	$("#notice").removeClass().addClass(className).html(message);
	$("#notice").slideDown("slow").delay(10000).slideUp("slow");
	$("#notice").click(function() {
		$("#notice").slideUp("slow");
	});
}

function showSuccessMessage(message){
	showSlidingMessage(message, 'success');
}

function showErrorMessage(message){
	showSlidingMessage(message, 'error');
}