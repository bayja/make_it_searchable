require 'make_it_searchable'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3", 
  :database => "make_it_searchable.sqlite3"
)

class CreateTestData < ActiveRecord::Migration
  def self.up
    create_table :lecture_reviews do |t|
      t.integer :lecture_id
      t.integer :region_id
      t.string :title
      t.string :body
      t.boolean :won
      t.boolean :best_review     
      
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

# CreateTestData.up