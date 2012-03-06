# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
jitu = User.create(:email => 'ashrafuzzaman.g2@gmail.com', :name => 'A.K.M. Ashrafuzzaman', :password => '123456')
setu = User.create(:email => 'zhd.zmn@gmail.com', :name => 'A.K.M. Zahiduzzaman', :password => '123456')
arif = User.create(:email => 'arif@orbund.com', :name => 'Arif Joarder', :password => 'orbund20')

stubbles = Project.create(:name => 'Stubbles', :creator => jitu, :description => 'Sample description', :started_on => 1.days.ago)
Project.create(:name => 'Newton freshair', :creator => setu, :description => 'Sample description', :started_on => 1.week.ago)

stubbles.memberships.create(:user => arif, :role => Role::ADMIN)
stubbles.memberships.create(:user => jitu, :role => Role::ADMIN)
stubbles.memberships.create(:user => setu, :role => Role::MEMBER)

stubbles.stories.create(:title => 'Story 1', :assigned_to => jitu)
stubbles.stories.create(:title => 'Story 2', :assigned_to => setu)
stubbles.stories.create(:title => 'Story 3', :assigned_to => setu, :scope => Scope::CURRENT)
stubbles.stories.create(:title => 'Story 4', :assigned_to => setu)