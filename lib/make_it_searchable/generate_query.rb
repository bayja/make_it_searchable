# encoding: utf-8

module MakeItSearchable::GenerateQuery
  
  def _generate_query(column_and_option, value)
    return self.scoped unless value.present?
    return self.scoped unless _valid_filter_option?(column_and_option)

    custom_scope = self.scoped

    column, query_option = MakeItSearchable._extract_column_name_and_query_option(column_and_option)
    
    case query_option
    when 'eq'
      if value == 'true' or value == 'false'
        custom_scope = custom_scope.where( column => (value == 'true') )
      else
        custom_scope = custom_scope.where(column => value)
      end
    when 'gt'
      custom_scope = custom_scope.where("#{column} > ?", "#{value}")
    when 'lt'
      custom_scope = custom_scope.where("#{column} < ?", "#{value}")
    when 'gte'
      custom_scope = custom_scope.where("#{column} >= ?", "#{value}")
    when 'lte'
      custom_scope = custom_scope.where("#{column} <= ?", "#{value}")
    else
      if value.to_s.match(/([\u3131-\u318E]|[\uAC00-\uD7A3])/) # if Korean
        custom_scope = custom_scope.where("replace(#{column}, ' ', '') LIKE ?", "%#{value.to_s.gsub(/\s/, '')}%")
      else
        custom_scope = custom_scope.where("#{column} LIKE ?", "%#{value}%")
      end
    end
  
    custom_scope
  end
  
end