class StoryCalendarController < ApplicationController
  before_filter :load_project, :authenticate_user!
	
  def index
  end

  def update_scheduled_start_at
    @story = @project.stories.find(params[:id])
    scheduled_start_at = time_after_delta(@story.scheduled_start_at)
    scheduled_complete_at = time_after_delta(@story.scheduled_complete_at)
    if @story.update_attributes({:scheduled_start_at => scheduled_start_at, 
                                  :scheduled_complete_at => scheduled_complete_at})
      flash[:notice] = "Story scheduled on #{scheduled_start_at}"
    else
      flash[:error] = @story.errors
    end
  end

  def update_scheduled_complete_at
    @story = @project.stories.find(params[:id])
    scheduled_complete_at = time_after_delta(@story.scheduled_complete_at)
    if @story.update_attributes(:scheduled_complete_at => scheduled_complete_at)
      flash[:notice] = "Story estimated complete on #{scheduled_complete_at}"
    else
      flash[:error] = @story.errors
    end
  end

	private

  def time_after_delta(time)
    time = (time || DateTime.now) + params[:dayDelta].to_i
    time.advance(:minutes => params[:minuteDelta].to_i)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end