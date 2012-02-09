var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function() {
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR,
		forcePlaceholderSize: true,
		handle: '.portlet-header',
		stop: function(event, ui){
			//var storyId = ui.item.attr('id').split('_')[1];
			var scope = ui.item.closest(SORTABLE_COLUMN_SELECTOR).attr('data-scope');
			var storyIds = ui.item.closest(SORTABLE_COLUMN_SELECTOR).sortable('toArray');
			//showMessage(storyId + ' ' + PROJECT_ID + ' ' + scope);
			//storyElements = storyElements.replace('story_', '');
			//storyElements = storyElements.join(', ');

			var storiesJson = [];
			for(var i = 0, len = storyIds.length; i < len; i++) {
				var storyJson = { "id" : storyIds[i] };
				storiesJson.push(storyJson);
			}

			var changes = { 
				"projectId": PROJECT_ID,
				"scope": scope,
			    "stories": storiesJson
			}
			showMessage(changes);
		}
	});
	$( ".portlet" ).updateDom();
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
});

function updateChanges( changes ){
	$.post("test.php", changes );
}