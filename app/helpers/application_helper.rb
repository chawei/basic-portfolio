module ApplicationHelper
  def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end
  
  def add_object_link(name, form, object, partial, where)
    html = render(:partial => partial, :locals => { :form => form}, :object => object)
    link_to_function name, %{
      var new_object_id = new Date().getTime() ;
      var html = $(#{js html}.replace(/index_to_replace_with_js/g, new_object_id)).hide();
      html.appendTo($("#{where}")).show();
    }
  end
  
  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end
end
