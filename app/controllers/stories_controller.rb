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
      format.html # new.html.erb
      format.json { render :json => @story }
      format.js
    end
  end

  # GET /stories/1/edit
  def edit
    @story = @project.stories.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @story }
      format.js
    end
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = @project.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to [@project, @story], :notice => 'Story was successfully created.' }
        format.json { render :json => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    @story = @project.stories.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to [@project, @story], :notice => 'Story was successfully updated.' }
        format.json { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.json { render :json => @story.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story = @project.stories.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :ok }
    end
  end
  
 private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
