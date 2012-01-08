# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
stubbles = Project.create(:name => 'Stubbles', :description => 'Sample description', :started_on => 1.days.ago)
Project.create(:name => 'Newton freshair', :description => 'Sample description', :started_on => 1.week.ago)

jitu = User.create(:email => 'ashrafuzzaman.g2@gmail.com', :name => 'A.K.M. Ashrafuzzaman', :password => '123456')
setu = User.create(:email => 'zhd.zmn@gmail.com', :name => 'A.K.M. Zahiduzzaman', :password => '123456')

stubbles.stories.create(:title => 'Story 1', :assigned_to => jitu)
stubbles.stories.create(:title => 'Story 2', :assigned_to => setu)