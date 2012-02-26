class TasksController < ApplicationController
  before_filter :load_story, :authenticate_user!
  def index
    @tasks = @story.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tasks }
      format.js
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @story.tasks.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render :json => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = @story.tasks.new

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.json { render :json => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @story.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @story.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.js
        format.html { redirect_to [@story, @task], :notice => 'Task was successfully created.' }
        format.json { render :json => @task, :status => :created, :location => @task }
        flash[:notice] = "Task created"
      else
        format.js
        format.html { render :action => "new" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
        flash[:error] = @task.errors
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = @story.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to [@story, @task], :notice => 'Task was successfully updated.' }
        format.json { head :ok }
        format.js
        flash[:notice] = "Task created"
      else
        format.html { render :action => "edit" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
        format.js
        flash[:error] = @task.errors
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @story.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to tasks_url }
      format.json { head :ok }
      flash[:notice] = "Task deleted"
    end
  end

  private

  def load_story
    @story = Story.find(params[:story_id])
  end

end