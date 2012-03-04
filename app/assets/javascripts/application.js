//= require jquery_ujs
//= require message
//= require ajax_loader

$(function() {
	$(".ui-button").button();

	addSubmitalbeElemntInForm();
	attachCancelSupport();

	$('body').on('ready', 'input.date', function() {
		$(this).datepicker();
	});

});

function addSubmitalbeElemntInForm() {
	$('body').on('change', '.submittable', function() {
		$(this).parents('form:first').submit();
	});
}

function attachCancelSupport(){
	$('body').on('click', 'a[data-cancel]',
		function(){
			var elementToClose = $(this).attr("data-cancel");
			$(this).closest(elementToClose).slideUp('fast', function() {
    			$(this).remove();
			});
		}
	);
}