module StoriesHelper
  def assigned_person_for(model)
    model.assigned_to.nil? ? 'n/a' : model.assigned_to.name
  end
  
  def ajax_cancel_link(model)
    if(!model.new_record?)
      link_to "cancel", {:action => "show"}, :remote => true
    else
      #TODO: Add UJS for deleting the parent form
      link_to "cancel", '#', :'data-cancel' => :form
    end
  end
  
  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end
end