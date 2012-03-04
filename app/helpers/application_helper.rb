module ApplicationHelper
  def container_id_of(model)
    model.new_record? ? 'new' : "#{model.class.name.downcase}-#{model.id}"
  end
  
  def box_container(containerId, options = {})
    custom_class = options[:class]
    options.delete(:class)
    options_as_array = options.collect{ |key, value| "#{key} = \"#{value}\""}
  	concat <<-EOF.html_safe
    	<div id='#{containerId}' #{options_as_array.join(' ')} class="#{custom_class}">
  	EOF
  	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def box_header()
  	concat <<-EOF.html_safe
    	<div class="header">
  	EOF
    yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def box_content()
  	concat <<-EOF.html_safe
    	<div class="content" style="display: block; "><div class="line"></div>
  	EOF
    yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def ajax_cancel_link(model, removeElement = 'form')
    if(!model.new_record?)
      link_to "cancel", {:action => "show"}, :remote => true, :'data-disable-with' => "canceling..."
    else
      link_to "cancel", '#', :'data-cancel' => removeElement, :'data-disable-with' => "canceling..."
    end
  end

  def deactivate_link(model, activate_path, deactivate_path)
    text = model.active? ? 'Deactivate' : 'Activate'
    path = model.active? ? deactivate_path :  activate_path
    return link_to text, path, :confirm => 'Are you sure?', :method => :put, :remote=>true
  end

  def error_message
    escape_javascript(render :partial => 'shared/errors', :locals => {:errors => flash[:error]})
  end

  def execute_js_if(success)
    if success
      yield
      concat "showSuccessMessage('#{escape_javascript(flash[:notice])}');"
    else
      concat "showErrorMessage('#{escape_javascript(error_message)}');"
    end
  end
end