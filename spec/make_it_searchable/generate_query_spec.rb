# encoding: utf-8

require 'spec_helper'

class LectureReview < ActiveRecord::Base
  extend MakeItSearchable::GenerateQuery
  belongs_to :lecture
end

class Lecture < ActiveRecord::Base
  extend MakeItSearchable::GenerateQuery
  has_many :lecture_reviews
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
  
  context 'translate join query options' do
    it 'should generate join filter query' do
      LectureReview._generate_query("lectures.title-eq", 2).to_sql.should == (
        LectureReview.joins(:lecture).where("lectures.title" => 2).to_sql
      )
    end
  end

  context 'add inner join' do
    it 'should add inner join query with sigular association name' do
      LectureReview._add_inner_join(LectureReview.scoped, 'lectures.title').to_sql.should == (
        LectureReview.scoped.joins(:lecture).to_sql
      )
    end

    it 'should add inner join query with plural association name' do
      Lecture._add_inner_join(Lecture.scoped, 'lecture_reviews.title').to_sql.should == (
        Lecture.scoped.joins(:lecture_reviews).to_sql
      )
    end
  end
  
end



