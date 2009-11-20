# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def default_content_for(name, &block)
    name = name.kind_of?(Symbol) ? ":#{name}" : name
    out = eval("yield #{name}", block.binding)
    concat(out || capture(&block), block.binding)
  end
  
  
end
