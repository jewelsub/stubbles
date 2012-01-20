module ApplicationHelper
  def container_id_of(model)
    model.new_record? ? 'new' : "#{model.class.name.downcase}_#{model.id}"
  end
  
  def content_for_widget(container_id)
    puts %w(<div id='#{container_id}' class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">)
      yield
    puts %w(</div>)
  end
end