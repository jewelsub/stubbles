class ProjectMembership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :role, :inclusion => { :in => %w(member admin stakeholder), :message => "%{value} is not a valid role" }

end
