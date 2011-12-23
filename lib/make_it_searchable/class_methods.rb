# encoding: utf-8

module MakeItSearchable::ClassMethods
  
  def make_it_search(sort_option, filter_option)
    make_it_sort(sort_option).make_it_filter(filter_option)
  end
  
  def make_it_filter(options = nil)
    custom_scope = scoped
    if options.present?
      options.each { |key, value| custom_scope = custom_scope._generate_query(key, value) }
      custom_scope
    end
    custom_scope
  end
  
  def make_it_sort(name_and_option, default_order = "created_at DESC")
    if _valid_sort_option?(name_and_option)
      column_name, direction = MakeItSearchable._extract_column_name_and_query_option(name_and_option)
      # direction = "_" if direction.nil?
      order("#{column_name} #{direction}")
    else
      send(:order, default_order)
    end
  end
end