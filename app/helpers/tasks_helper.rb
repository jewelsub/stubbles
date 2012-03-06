module TasksHelper
  def action_links_for_task(task)
  	content_tag :div, :style => 'float: left;' do
  		form_tag(update_status_story_task_path(task.story, task), 
                    :method => :put, :remote=>true) do
  			task.current_state.events.keys.each do |event|
  				concat(submit_tag(event, :name => 'event', :value => event, 
                            :class => "#{event} button small",
                            :'data-disable-with' => 'wait'))
  			end
  		end
  	end
  end
end
