class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @stories = @project.stories

    respond_to do |format|
      format.html
      format.json { render :json => @stories }
      format.js
    end
  end
end
