// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui

//adding the sortability in the sortable_column
// as well as adding the appropriate classes for the widget
var SORTABLE_COLUMN_SELECTOR = ".sortable_column";

(function( $ ){
  $.fn.updateDom = function() {
	$(this).find( ".portlet-header .ui-icon" ).click(function() {
		$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
		$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
	});
	return this;
  };
})( jQuery );

$(function() {
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR
	});
	$( ".portlet" ).updateDom();
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
	$('.submittable').live('change', function() {
		$(this).parents('form:first').submit();
	});
});