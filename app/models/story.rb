class Story < ActiveRecord::Base
  include Workflow

  belongs_to :project
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :tasks

  workflow_column :status
  workflow do
    state :new do
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

end