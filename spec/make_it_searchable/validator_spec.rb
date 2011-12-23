# encoding: utf-8
require 'spec_helper'

class LectureReview < ActiveRecord::Base
  extend MakeItSearchable::Validator
end

describe MakeItSearchable::Validator do
  it 'should validate sort option' do
    LectureReview._valid_sort_option?("region_id-asc").should be_true
    LectureReview._valid_sort_option?("lecture_id-desc").should be_true
    LectureReview._valid_sort_option?("lecture_id-aeae").should be_false
    LectureReview._valid_sort_option?("wrong_column_name-asc").should be_false

    LectureReview._valid_sort_option?("region_id").should be_true # rails default
  end
  
  it 'should validate filter option' do
    LectureReview._valid_filter_option?("lecture_id-eq").should be_true
    LectureReview._valid_filter_option?("lecture_id-gt").should be_true
    LectureReview._valid_filter_option?("lecture_id").should be_true
    
    LectureReview._valid_filter_option?("wrong_column_name").should be_false
  end
end