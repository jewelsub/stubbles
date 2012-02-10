class Project < ActiveRecord::Base
  has_many :stories, :order => 'priority'
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :users, :through => :memberships, :source => :user
  belongs_to :creator, :class_name => 'User', :readonly => :true

  after_create :add_creator_as_project_admin
  def collaborators
    self.users.where("(project_memberships.role = ? OR project_memberships.role = ?) 
                        AND active = ?", Role::ADMIN, Role::MEMBER, true)
  end

  private

  def add_creator_as_project_admin
    self.memberships.create(:user => creator, :role => Role::ADMIN)
  end
end