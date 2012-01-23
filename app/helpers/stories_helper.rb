module StoriesHelper
  def assigned_person_for(model)
    model.assigned_to.nil? ? 'n/a' : model.assigned_to.name
  end
  
  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end
end