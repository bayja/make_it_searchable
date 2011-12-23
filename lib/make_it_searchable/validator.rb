# encoding: utf-8

module MakeItSearchable::Validator
  def _valid_sort_option?(name_and_option)
    if name_and_option.present?
      column_name, direction = MakeItSearchable._extract_column_name_and_query_option(name_and_option)
      ["asc", "desc", nil].include?(direction) && column_names.include?(column_name.to_s)
    else
      false
    end
  end
  
  def _valid_filter_option?(name_and_option)
    if name_and_option.present?
      column_name, option = MakeItSearchable._extract_column_name_and_query_option(name_and_option)
      column_names.include?(column_name.to_s)
    else
      false
    end
  end
end

