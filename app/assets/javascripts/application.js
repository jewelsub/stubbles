//= require jquery_ujs
//= require notification
//= require ajax_loader
//= require lib/jquery.cleditor.js

$(function() {
	$(".ui-button").button();

	addSubmitalbeElemntInForm();
	attachCancelSupport();

	$('body').on('ready', 'input.date', function() {
		$(this).datepicker();
	});

	$('.richtext').cleditor({useCSS:true
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