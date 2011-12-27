class Task < ActiveRecord::Base
  belongs_to :story
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
end
