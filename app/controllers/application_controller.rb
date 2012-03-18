class ApplicationController < ActionController::Base
  protect_from_forgery

private 
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
    	project = resource.default_project
      project ? project_dashboard_path(project.id) : super
    else
      super
    end
	end
end