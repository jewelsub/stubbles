//= require jquery_ujs
//= require message
//= require ajax_loader

//adding the sortability in the sortable_column
// as well as adding the appropriate classes for the widget

$(function() {
	$("#dialog").hide();
	$("#loading").hide();
	$("#notice").hide();

	addSubmitalbeElemntInForm();
	addCollapseToggleForPortlet();
	attachAjaxLoading();
	attachCancelSupport();

	$('body').on('ready', 'input.date', function() {
		$(this).datepicker();
	});

});

function addCollapseToggleForPortlet() {
	$(".story_column").on('click', ".collapse, .expand", 
		function() {
			$(this).toggleClass("collapse").toggleClass("expand");
			$(this).parents(".portlet:first").find(".portlet-content").toggle("fast");;
		}
	);
}

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