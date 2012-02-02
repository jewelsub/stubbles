var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2];

alert(PROJECT_ID);

$(function() {
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR,
		forcePlaceholderSize: true,
		handle: '.portlet-header',
		receive: storyMoved
	});
	$( ".portlet" ).updateDom();
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
	$('.submittable').live('change', function() {
		$(this).parents('form:first').submit();
	});
});

function storyMoved( event, ui ){
	alert($(this).closest('div.story_column').attr('data-scope'));
}