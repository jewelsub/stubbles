class Project < ActiveRecord::Base
  has_many :stories
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :users, :through => :memberships, :source => :user

  def members
    self.users.where("role = #{Role::MEMBER}")
  end
end