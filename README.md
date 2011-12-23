# Make It Searchable

간단한 칼럼 filtering, sorting 기능 제공. 

## Installation

Add to your Gemfile and run the `bundle` command to install it.

```ruby
gem "make_it_seachable"
```

**Requires Ruby 1.9.2 or later.**


## Usage
Call 'make_it_seachable' in an ActiveRecord class

```ruby
class Lecture < ActiveRecord::Base
  make_it_seachable
end
```

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

