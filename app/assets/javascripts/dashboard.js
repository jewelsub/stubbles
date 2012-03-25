//= require tag.js

var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function() {
	$(SORTABLE_COLUMN_SELECTOR).sortable({
		connectWith: SORTABLE_COLUMN_SELECTOR,
		forcePlaceholderSize: true,
		handle: '.header',
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

	$(function() {
		$(".story_type").buttonset().removeClass("story_type");
		$("body").ajaxStop(function(){
			$(".story_type").buttonset().removeClass("story_type");
		});
	});

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
			$(this).closest(".story").find(".content:first").toggle("fast");
		}
	);
}

function hideAllPortlet() {
	$(".story .content").hide();
	$(".story .header").find(".icon.collapse").removeClass().addClass("icon expand");	
}

function toggleCollapse() {
	$(".header .collapse, .header .expand").click();
}

function addRichText(rootElement) {
  $(rootElement).find(".richtext").cleditor({width:440, height:180, useCSS:true})[0];
}