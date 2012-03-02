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

  def time_entry
    @project = Project.find(params[:project_id])
    @stories = @project.stories
    @beginning_of_week = Date.today.beginning_of_week
    @end_of_week = Date.today.end_of_week
    #@days << Date.commercial(2010, week, 1)
  end

  def update_time_entry
    conditions = {  :spent_on => params[:date], 
                    :user_id => current_user.id, 
                    :trackable_type => params[:resource], 
                    :trackable_id => params[:'resourceId'] }

    time_entry = TimeEntry.find_or_new(conditions)
    time_entry.hours_spent = params[:value]
    time_entry.save
  end

end