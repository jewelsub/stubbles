//= require tag.js

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

	updateStoryWidget(true);
	$("body").ajaxStop(function(){
		updateStoryWidget(false);
	});
});

function updateStoryWidget(collapse) {
	$(".story_type").buttonset().removeClass("story_type");
	addPortlets(collapse);
}

function updateChanges(changes){
	startLoading();
	$.post("/projects/" + PROJECT_ID + "/stories/update_scope_and_priority", 
		changes
	).complete(function() { stopLoading(); });
}

function toggleCollapse() {
	$(".portlet-header .collapsable").click();
}

function addRichText(rootElement) {
  $(rootElement).find(".richtext").cleditor({width:440, height:180, useCSS:true})[0];
}

function addPortlets(collapse) {
	var expand_class = "ui-icon-triangle-1-n";
	var collapse_class = "ui-icon-triangle-1-s";
	var init_class = collapse ? collapse_class : expand_class;
	$(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
			.find(".portlet-header")
				.addClass("ui-widget-header ui-corner-all")
				.prepend("<span class='collapsable ui-icon " + init_class + "' style='float: left;'></span>")
				.end()
			.find(".portlet-content");
	$(".portlet .portlet-header").click(function() {
		var element = $(this).find(".collapsable");
		element.toggleClass(collapse_class).toggleClass(expand_class);
		element.parents(".story:first").find(".portlet-content").toggle("fast");
	});
	if(collapse) $(".portlet-content").hide();
	$(".portlet").removeClass("portlet");
}