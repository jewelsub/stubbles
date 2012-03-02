class TimeEntry < ActiveRecord::Base
  belongs_to :trackable, :polymorphic => true
  scope :spent_on, lambda { |date| where(:spent_on => date) }
  scope :by, lambda { |user| where(:user_id => user.id) }

  def self.find_or_new(conditions)
		return TimeEntry.find(:first, :conditions => conditions) || TimeEntry.new(conditions) 
  end

end