module ProjectsHelper
	def user_filter(param_name)
		form_tag("", :method=> :get) do |f|
			select_tag(param_name, options_for_select(@project.collaborators
											.collect {|user| [ user.email, user.id ] }, 
											:selected => params[param_name]), 
											{:class => 'submittable',
											:prompt => ''})
		end

	end
end