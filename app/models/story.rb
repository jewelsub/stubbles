class Story < ActiveRecord::Base
  include Workflow

  belongs_to :project
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :tasks
  scope :current, where(:scope => Scope::CURRENT)
  scope :backlog, where(:scope => Scope::BACKLOG)
  scope :prioritized, order('priority')

  before_create :autogenerate_priority
  before_create :assign_default_scope

  workflow_column :status
  workflow do
    state :not_started do
      event :start, :transitions_to => :started
    end
    state :started do
      event :finish, :transitions_to => :finished
    end
    state :finished do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :rejected do
      event :reopen, :transitions_to => :started
    end
    state :accepted
  end

  #TODO: add validation so that no user can be added that is not in the following list
  def assignable_users
    project.collaborators
  end

  def total_hours_estimated
    hours_estimated || tasks.sum(:hours_estimated)
  end

  def total_hours_spent
    hours_spent || tasks.sum(:hours_spent)
  end

  def assigned?
    !self.assigned_to.nil?
  end

  ######################### Priority ##########################
  def self.update_scope_and_priority(project_id, scope, story_id, shift_from_story_id)
    project = Project.find(project_id)
    priority_to_assign = nil
    if(shift_from_story_id == 0)
      priority_to_assign = Story.lowest_priority_by_scope(project, scope) + 1
    else
      priority_to_assign = Story.find(shift_from_story_id).priority
    end
    shift_priority_from(project, priority_to_assign)
    #puts "story id: #{story.id} prev_priority: #{story.priority} new_priority: #{priorities[index]}\n"
    Story.find(story_id).update_attributes({:scope => scope, :priority => priority_to_assign})
  end

  def self.lowest_priority_by_scope(project, scope)
    priority = project.stories.where('scope' => scope).minimum('priority') || 1
  end

  def self.shift_priority_from(project, priority, shift_by = 1)
    project.stories.update_all("priority = priority + #{shift_by}", ['priority >= ?', priority])
  end
  ######################### Priority ##########################

  private
  def autogenerate_priority
    min_priority_in_scope = Story.lowest_priority_by_scope(project, Scope::BACKLOG)
    puts "Priority to assign :: #{min_priority_in_scope}"
    Story.shift_priority_from(project, min_priority_in_scope)
    self.priority = min_priority_in_scope
  end

  def assign_default_scope
    self.scope = Scope::BACKLOG
  end
end