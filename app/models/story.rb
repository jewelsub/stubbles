class Story < ActiveRecord::Base
  include Workflow

  belongs_to :project
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :tasks
  scope :current, where(:scope => Scope::CURRENT)
  scope :backlog, where(:scope => Scope::BACKLOG)
  scope :prioritized, order('priority')

  before_create :autogenerate_priority

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

  def self.update_scope_and_priority(project_id, scope, ordered_ids)
    project = Project.find(project_id)

    priorities = project.stories(ordered_ids).map(&:priority)
    priorities.sort {|x,y| y <=> x }

    ordered_ids.each_with_index { |story_id, index|
      story = project.stories.find(story_id)
      puts "story id: #{story.id} prev_priority: #{story.priority} new_priority: #{priorities[index]}\n"
      story.update_attributes({:scope => scope, :priority => priorities[index]})
    }
  end

  private
  def autogenerate_priority
    max_priority = project.stories.maximum('priority') || 0
    self.priority = max_priority + 1
  end
end