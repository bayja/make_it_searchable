# encoding: utf-8

require 'spec_helper'

class LectureReview < ActiveRecord::Base
  extend MakeItSearchable::GenerateQuery
end

describe MakeItSearchable::GenerateQuery do

  context 'translate query option' do
    it 'should generate filter query' do
      LectureReview._generate_query("lecture_id-eq", 2).to_sql.should == (
        LectureReview.where(:lecture_id => 2).to_sql
      )
      LectureReview._generate_query("lecture_id-gte", 2).to_sql.should == (
        LectureReview.where("lecture_id >= ?", "2").to_sql
      )
      LectureReview._generate_query("region_id-lt", 10).to_sql.should == (
        LectureReview.where("region_id < ?", "10").to_sql
      )
      LectureReview._generate_query("title", '보리 출판사').to_sql.should == (
        LectureReview.where("replace(title, ' ', '') LIKE ?", "%보리출판사%").to_sql
      )
      LectureReview._generate_query("title", 'English').to_sql.should == (
        LectureReview.where("title LIKE ?", "%English%").to_sql
      )
      LectureReview._generate_query("won-eq", 'true').to_sql.should == (
        LectureReview.where(:won => true).to_sql
      )
      LectureReview._generate_query("won-eq", 'false').to_sql.should == (
        LectureReview.where(:won => false).to_sql
      )
      
    end

    it 'should fall back to default scope when invalid filter option provied' do
      LectureReview._generate_query("wrong_column_name", 2).to_sql.should == (
        LectureReview.scoped.to_sql
      )
    end

    it 'should fall back to default scope when no value has provided' do
      LectureReview._generate_query("title", '').to_sql.should == (
        LectureReview.scoped.to_sql
      )
    end
  end
  
end 


