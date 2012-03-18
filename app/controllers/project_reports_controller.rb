class ProjectReportsController < ApplicationController
  before_filter :load_project, :authenticate_user!
	
  def sprint_burndown
    @users = @project.collaborators
  end

	private

  def load_project
    @project = Project.find(params[:project_id])
  end
end