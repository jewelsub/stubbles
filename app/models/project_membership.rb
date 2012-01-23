class ProjectMembership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :role, :inclusion => { :in => %w(member admin stakeholder), :message => "%{value} is not a valid role" }

  def activate
  	update_attribute(:active, true)
  end

  def deactivate
  	update_attribute(:active, false)
  end

end
