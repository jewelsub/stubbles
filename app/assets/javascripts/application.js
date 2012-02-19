//= require jquery
//= require jquery_ujs
//= require jquery-ui

//adding the sortability in the sortable_column
// as well as adding the appropriate classes for the widget

$(function() {
	$("#dialog").hide();
	$("#loading").hide();

	addSubmitalbeElemntInForm();
	addCollapseToggleForPortlet();
	attachAjaxLoading();
	attachCancelSupport();
});

function showMessage(message){
	$("#dialog").html(message).dialog();
}

function attachAjaxLoading(){
	//this is a global handler that stop is there is any loading going on
	$('body').bind('ajaxComplete', function() {
		afterAjax();
		stopLoading();
	});
	$('a[data-start-loading="true"], form[data-start-loading="true"]').live('ajax:before',
	  function(e, data, textStatus, jqXHR){
	    startLoading();
	  }
	);
}

function afterAjax() {
	$('input.date').datepicker();
	//addCollapseToggleForPortlet();
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
	$(".portlet-header .collapse, .portlet-header .expand").live('click', function() {
		$(this).toggleClass("collapse").toggleClass("expand");
		$(this).parents(".portlet:first").find(".portlet-content").toggle("fast");;
	});
}

function addSubmitalbeElemntInForm() {
	$('.submittable').live('change', function() {
		$(this).parents('form:first').submit();
	});
}

function attachCancelSupport(){
	$('a[data-cancel]').live('click',
		function(){
			var elementToClose = $(this).attr("data-cancel");
			$(this).closest(elementToClose).slideUp('fast', function() {
    			$(this).remove();
			});
		}
	);
}