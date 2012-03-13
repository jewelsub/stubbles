module ProjectsHelper
	def user_filter(param_name, relay_params = [])
		form_tag("", :method=> :get) do |f|
			concat select_tag(param_name, options_for_select(@project.collaborators
											.collect {|user| [ user.email, user.id ] }, 
											:selected => params[param_name]), 
											{:class => 'submittable',
											:prompt => ''})
			relay_params.each do |param|
				concat hidden_field_tag param, params[param]
			end
		end
	end
end