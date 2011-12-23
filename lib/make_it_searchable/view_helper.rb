# encoding: utf-8

module MakeItSearchable::ViewHelper
  def get_direction(column_name, a_string)
    reg = /\A(?<column_name>(.+))-(?<direction>(asc|desc))\Z/
    md = reg.match(a_string)
    
    if md && md[:column_name] == column_name && md[:direction]
      md[:direction]
    end
  end
  
  def toggle_direction(a_string)
    reg = /-(?<direction>(asc|desc))\Z/
    md = reg.match(a_string)
    
    if md && md[:direction] == "asc"
      a_string.sub(reg, "-desc")
    elsif md && md[:direction] == "desc"
      a_string.sub(reg, "-asc")
    else
      a_string
    end
  end
end
