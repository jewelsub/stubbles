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
(function( $ ){
  $.fn.addPortletClassesToDom = function() {
    this.addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
		.find( ".portlet-header" )
			.addClass( "ui-widget-header ui-corner-all" )
			.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
			.end()
		.find( ".portlet-content" );

	$( this, ".portlet-header .ui-icon" ).click(function() {
		$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
		$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
	});
	return this;
  };
})( jQuery );

$(function() {
	$( ".sortable_column" ).sortable({
		connectWith: ".column"
	});
	$( ".portlet" ).addPortletClassesToDom ();
	$( ".sortable_column" ).disableSelection();
});