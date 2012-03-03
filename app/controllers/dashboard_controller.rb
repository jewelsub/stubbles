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
    @stories = @project.stories.assigned_to_task(current_user)
    @beginning_of_week = Date.today.beginning_of_week
    @end_of_week = Date.today.end_of_week
  end

  def update_time_entry
    time_entry =  Task.find(params[:'resourceId'])
                      .time_entries.spent_on(params[:date])
                      .by(current_user).first_or_create
    time_entry.hours_spent = params[:value]
    time_entry.save
  end

end