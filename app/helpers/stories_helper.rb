module StoriesHelper
  def assigned_person_for(story)
    story.assigned_to.nil? ? 'Yet to be assigned' : story.assigned_to.name
  end
  
  def ajax_cancel_link(story)
    if(!story.new?)
      link_to "cancel", {:action => "show"}, :remote => true
    else
      #TODO: Add UJS for deleting the parent form
      link_to "cancel", '#', :'data-cancel' => :form
    end
  end
  
  def container_id_of(story)
    story.new? ? 'new' : "story_#{story.id}"
  end

  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end
end