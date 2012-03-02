module TimeEntryHelper
	def time_entry_slot_for(task, date)
		time_spent = task.total_hours_worked(date)
		content_tag(:span, time_spent, :class => 'time_entry editable', 
			:'data-resource' => "Task", :'data-resource-id' => task.id, 
			:'data-date' => date)
	end
end
