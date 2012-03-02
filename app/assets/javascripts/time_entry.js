var url = "/projects/1/time_entry";

$(function() {
	$(document).on('click', ".editable:not(.editing)", 
		function() {
			makeEditable($(this));
		}
	);

});

function makeEditable(element) {
	var prevValue = element.html();
	var editableElement = '<input type="text" class="inline_editor" size="2"' +
												'value="' + prevValue + '"></input>';
	element.addClass("editing").html('').append(editableElement);

	element.keydown(function(e) {
    if (e.keyCode == 27) { // ESCAPE key pressed
        doneEditing(element, prevValue);
    } else if(e.keyCode == 13) { //Enter keycode
    	var newValue = element.find(".inline_editor").val();
			postValue(element, newValue);
		}
	});
}

function postValue(element, value) {
	showMessage(element.data());
	doneEditing(element, value);
}

function doneEditing(element, value) {
	element.removeClass("editing").html(value);
}