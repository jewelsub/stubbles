class Task < ActiveRecord::Base
  include Workflow

  belongs_to :story
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many   :time_entries, :as => :trackable
  scope :assigned_to, lambda { |user| where(:assigned_to_id => user.id) }

  workflow_column :status
  workflow do
    state :new do
      event :start, :transitions_to => :started
    end
    state :started do
      event :finish, :transitions_to => :finished
    end
    state :finished
  end

  def total_hours_worked(date)
    time_entries.spent_on(date).by(assigned_to).sum('hours_spent')
  end

end
