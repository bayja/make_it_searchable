# Make It Searchable

간단한 칼럼 filtering, sorting 기능, 아직 마무리 안됨.


### Filtering
```ruby
  ActiveRecordModel.custom_filter({:column_name => "query_string", :another_column => 'another_query_string'})
```
### Sorting
```ruby
  ActiveRecordModel.custom_order("#{column_name}_asc")
  ActiveRecordModel.custom_order("#{column_name}_desc")
```

### Filtering and Sorting
```ruby
  ActiveRecordModel.custom_query({:column_name => "query_string"}, "#{column_name}_desc")
```

