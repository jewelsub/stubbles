module StoriesHelper
  def assigned_person_for(model)
    model.assigned_to.nil? ? 'n/a' : model.assigned_to.name
  end
  
  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end

  def action_links_for_story(story)
  	content_tag :div, :style => 'float: left; margin-top: -3px; padding: 0px;' do
  		form_tag(update_status_project_story_path(story.project, story), 
                    :method => :put, :remote=>true) do
  			story.current_state.events.keys.each do |event|
  				concat(submit_tag(event, :name => 'event', :value => event, 
                            :class => "#{event} button small",
                            :'data-disable-with' => 'wait'))
  			end
  		end
  	end
  end
end