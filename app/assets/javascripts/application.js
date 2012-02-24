//= require jquery_ujs

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

function attachAjaxLoading(){
	//this is a global handler that stop is there is any loading going on
	$('body').on('ajaxComplete', function() {
		stopLoading();
	});
	$('body').on('ajax:before',
	  'a[data-start-loading="true"], form[data-start-loading="true"]',
	  function(e, data, textStatus, jqXHR){
	    startLoading();
	  }
	);
}

function startLoading(){
	$("#loading").dialog({ 
		modal: true,
		resizable: false,
		closeOnEscape: true,
		width: 260,
		height: 80
	});
}

function stopLoading(){
	$("#loading").dialog("close");
}

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