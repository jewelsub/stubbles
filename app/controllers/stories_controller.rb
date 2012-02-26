class StoriesController < ApplicationController
  before_filter :load_project, :authenticate_user!
  
  def index
    @stories = @project.stories

    respond_to do |format|
      format.html
      format.json { render :json => @stories }
      format.js
    end
  end

  def show
    @story = @project.stories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @story }
      format.js
    end
  end

  def new
    @story = @project.stories.new

    respond_to do |format|
      format.js
      format.html
      format.json { render :json => @story }
    end
  end

  def edit
    @story = @project.stories.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @story }
      format.js
    end
  end

  def create
    @story = @project.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to project_stories_path(@project), :notice => 'Story was successfully created.' }
        format.json { render :json => @story, :status => :created, :location => @story }
        format.js
        flash[:notice] = "Story created"
      else
        format.html { render :action => "new" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
        format.js
        flash[:error] = @story.errors
      end
    end
  end

  def update
    @story = @project.stories.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to [@project, @story], :notice => 'Story was successfully updated.' }
        format.json { head :ok }
        format.js
        flash[:notice] = "Story updated"
      else
        format.html { render :action => "edit" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
        format.js
        flash[:error] = @story.errors
      end
    end
  end

  def update_status
    @story = @project.stories.find(params[:id])

    respond_to do |format|
      if @story.send("#{params[:event]}!")
        format.js
      else
        format.js
      end
    end
  end

  def update_scope_and_priority
    scope               = params[:scope]
    story_id            = params[:story_id].to_i
    shift_from_story_id = params[:shift_from_story_id].to_i
    Story.update_scope_and_priority(@project, scope, story_id, shift_from_story_id)
  end

  def destroy
    @story = @project.stories.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
      format.js
      flash[:notice] = "Story deleted"
    end
  end
  
 private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
