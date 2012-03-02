module TimeEntryHelper
	def time_entry_slot_for(model, date)
		time_spent = 0
		content_tag(:span, time_spent, :class => 'time_entry editable', 
			:'data-resource' => "task", :'data-resource-id' => model.id, 
			:'data-date' => date)
	end
end
