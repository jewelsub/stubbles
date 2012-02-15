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

			for(var i = 0, len = storyIds.length; i < len; i++) {
				storyIds[i] = storyIds[i].replace('story_', '');
			}

			var changes = { 
				"scope": scope,
			    "story_ids": storyIds
			}
			updateChanges(changes);
		}
	});
	$( ".portlet" ).updateDom();
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
	$("#toggleCollapse").click(function() {
		toggleCollapse();
	});
	toggleCollapse();
});

function updateChanges(changes){
	startLoading();
	$.post("/projects/" + PROJECT_ID + "/stories/update_scope_and_priority", 
		changes
    ).complete(function() { stopLoading(); });
}

function toggleCollapse() {
	$(".portlet-header .ui-icon").click();
}