class Task < ActiveRecord::Base
  include Workflow

  belongs_to :story
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"

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

  def new?
    self.id ? false : true
  end
end
