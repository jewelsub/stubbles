class DashboardController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js, :json, :html, :xml

  def index
    @current_stories = filtered_stories.current
    @backlog_stories = filtered_stories.backlog
    respond_with(@stories)
  end

private
  def filtered_stories
    @project = Project.find(params[:project_id])
    stories = @project.stories.prioritized.yet_to_be_accepted
    stories = stories.involved_with(params[:involved_with]) if params[:involved_with].to_i > 0
    stories
  end
end