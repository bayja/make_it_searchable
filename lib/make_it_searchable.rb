require "active_support"
require "make_it_searchable/version"
require "make_it_searchable/class_methods"
require "make_it_searchable/generate_query"

require "make_it_searchable/validator"
require 'make_it_searchable/view_helper' 

require "make_it_searchable/railtie" if defined? Rails

module MakeItSearchable
  def self._extract_column_name_and_query_option(column_and_option)
    reg = /\A(?<column>(.+))-(?<query_option>(eq|gt|lt|gte|lte|asc|desc))\Z/
    md = reg.match(column_and_option.to_s)
  
    if md
      column, query_option = md[:column], md[:query_option]
    else
      column, query_option = column_and_option, nil
    end
  
    [column, query_option]
  end
end


