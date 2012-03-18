class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me  
  has_many :stories
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :projects, :through => :memberships, :source => :project

  def default_project
  	projects.order("created_at DESC").try(:first)
  end
end