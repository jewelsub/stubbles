class TimeEntry < ActiveRecord::Base
  belongs_to :trackable, :polymorphic => true
end