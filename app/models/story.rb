class Story < ActiveRecord::Base
  include Workflow

  belongs_to :project
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :tasks
  scope :current, where(:scope => Scope::CURRENT)
  scope :backlog, where(:scope => Scope::BACKLOG)

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
    state :accepted
    state :rejected
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
end