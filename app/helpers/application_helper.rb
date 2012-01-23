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

  def ajax_cancel_link(model)
    if(!model.new_record?)
      link_to "cancel", {:action => "show"}, :remote => true
    else
      #TODO: Add UJS for deleting the parent form
      link_to "cancel", '#', :'data-cancel' => :form
    end
  end

  def deactivate_link(model, activate_path, deactivate_path)
    text = model.active? ? 'Deactivate' : 'Activate'
    path = model.active? ? deactivate_path :  activate_path
    return link_to text, path, :confirm => 'Are you sure?', :method => :put, :remote=>true
  end
end