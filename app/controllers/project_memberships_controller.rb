class ProjectMembershipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project
  before_filter :find_user, :only => :create
  def index
    @project_memberships = @project.memberships
    @project_membership = ProjectMembership.new

    respond_to do |format|
      format.html
      format.json { render :json => @project_memberships }
    end
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @project_membership = @project.memberships.new({:user => @user}.merge(params[:project_membership]))

    respond_to do |format|
      if @project_membership.save
        format.html { redirect_to project_project_memberships_url(@project), :notice => 'User was successfully added.' }
        format.json { render :json => @project_membership, :status => :created, :location => @project }
        format.js
      else
        format.html { render :action => "index" }
        format.json { render :json => @project_membership.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @project_membership = @project.memberships.find(params[:id])
    @project_membership.destroy

    respond_to do |format|
      format.html { redirect_to project_project_memberships_url(@project) }
      format.json { head :ok }
      format.js
    end

  end

  private

  def load_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_user
    @user = User.find_by_email(params[:email])
    if @user.nil?
      redirect_to project_project_memberships_url(@project), :notice => 'User not found'
      return false
    else
      return true
    end
  end

  def update_role
    @project = current_user.projects.find(params[:project_id])
    @project_membership = @project.memberships.new({:user => @user}.merge(params[:project_membership]))

    respond_to do |format|
      if @project_membership.update(:role, params[:role])
        format.html { redirect_to project_project_memberships_url(@project), :notice => 'Role updated.' }
        format.json { render :json => @project_membership, :status => :created, :location => @project }
        format.js
      else
        format.html { render :action => "index" }
        format.json { render :json => @project_membership.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

end