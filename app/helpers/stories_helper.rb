module StoriesHelper
  def assigned_person_for(story)
    story.assigned_to.nil? ? 'Yet to be assigned' : story.assigned_to.name
  end
end