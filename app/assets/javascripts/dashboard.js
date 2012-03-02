var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function() {
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR,
		forcePlaceholderSize: true,
		handle: '.portlet-header',
		stop: function(event, ui){
			var scope = ui.item.closest(SORTABLE_COLUMN_SELECTOR).attr('data-scope');
			var storyElem = ui.item;
			var storyId = storyElem.attr("id").replace('story-', '');
			var nextStoryElem = storyElem.next(".story");
			var nextStoryId = nextStoryElem.length == 0 ? 0 : nextStoryElem.attr("id").replace('story-', '');

			var changes = { 
				"scope": scope,
				"story_id": storyId,
				"shift_from_story_id": nextStoryId
			}
			updateChanges(changes);
		}
	});
	$(SORTABLE_COLUMN_SELECTOR).disableSelection();
	$("#toggleCollapse").click(function() {
		toggleCollapse();
	});
	addCollapseToggleForPortlet();
	hideAllPortlet();
});

function updateChanges(changes){
	startLoading();
	$.post("/projects/" + PROJECT_ID + "/stories/update_scope_and_priority", 
		changes
	).complete(function() { stopLoading(); });
}
	
function addCollapseToggleForPortlet() {
	$(".story_column").on('click', ".collapse, .expand", 
		function() {
			$(this).toggleClass("collapse").toggleClass("expand");
			$(this).parents(".portlet:first").find(".portlet-content").toggle("fast");
		}
	);
}

function hideAllPortlet() {
	$(".portlet .portlet-content").hide();
	$(".portlet .portlet-header").find(".icon.collapse").removeClass().addClass("icon expand");	
}

function toggleCollapse() {
	$(".portlet-header .collapse, .portlet-header .expand").click();
}