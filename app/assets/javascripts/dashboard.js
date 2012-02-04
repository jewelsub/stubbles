var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function() {
	$( "#dialog" ).hide();
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR,
		forcePlaceholderSize: true,
		handle: '.portlet-header',
		stop: function(event, ui){
			var storyId = ui.item.attr('id').split('_')[1];
			var scope = ui.item.closest(SORTABLE_COLUMN_SELECTOR).attr('data-scope');
			$( "#dialog" ).html(storyId + ' ' + PROJECT_ID + ' ' + scope).dialog();

		}
	});
	$( ".portlet" ).updateDom();
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
});

function storyMoved( event, ui ){
	var result = $(this).sortable('toArray');
	alert(result);
	/*
	$.ajax({
	  type: "PUT",
	  url: "/stories/:story_id/tasks/:id",
	  data: "name=John&location=Boston",
	  dataType: 'json'
	}).done(function( msg ) {
	  alert( "Data Saved: " + msg );
	});
	*/
}