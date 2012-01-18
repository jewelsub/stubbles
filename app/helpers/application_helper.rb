module ApplicationHelper
  def container_id_of(model)
    model.new? ? 'new' : "#{model.class.name.downcase}_#{model.id}"
  end
end