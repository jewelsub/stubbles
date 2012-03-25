module TagFormHelper

	class ActionView::Helpers::FormBuilder
	  def tag(method, options = {})
	  	available_tags = (options[:available_tags] || []).collect { |tag| tag.name }.join ','
	    @template.content_tag :ul, {:'data-item-name' => @object_name, 
	    											:'data-field-name' => method, 
	    											:class => 'tag-it',
	    											:'data-available-tags' => available_tags} do
				@object.send(method).each do |tag|
					@template.concat(@template.content_tag(:li, tag))
				end
    	end
	  end
	end

	def tags_tag
		
	end
end