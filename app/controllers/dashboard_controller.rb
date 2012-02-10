class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @stories = @project.stories
    @current_stories = @project.stories.current.prioritized
    @backlog_stories = @project.stories.backlog.prioritized

    respond_to do |format|
      format.html
      format.json { render :json => @stories }
      format.js
    end
  end
end
