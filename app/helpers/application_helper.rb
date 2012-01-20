module ApplicationHelper
  def container_id_of(model)
    model.new_record? ? 'new' : "#{model.class.name.downcase}_#{model.id}"
  end
  
  def content_for_widget(container_id)
    puts %w(<div id='#{container_id}' class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">)
      yield
    puts %w(</div>)
  end
  def box_container(containerId)
  	concat <<-EOF.html_safe
    	<div id='#{containerId}' class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
  	EOF
	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def box_header()
  	concat <<-EOF.html_safe
    	<div class="portlet-header ui-widget-header ui-corner-all"><span class="ui-icon ui-icon-minusthick"></span>
  	EOF
	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def box_content()
  	concat <<-EOF.html_safe
    	<div class="portlet-content" style="display: block; ">
  	EOF
	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end
end