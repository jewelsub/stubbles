module StoriesHelper
  def assigned_person_for(story)
    story.assigned_to.nil? ? 'Yet to be assigned' : story.assigned_to.name
  end
  
  def ajax_cancel_link(story)
    if(!story.new?)
      link_to "cancel", {:action => "show"}, :remote => true
    end
  end
  
  def container_id_of(story)
    story.new? ? 'new' : story.id
  end
end