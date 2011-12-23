# encoding: utf-8
require 'spec_helper'

class LectureReview < ActiveRecord::Base
  extend MakeItSearchable::ClassMethods
end

describe MakeItSearchable::ClassMethods do
  context "filtering and sorting" do
    before :each do
      LectureReview.destroy_all
      @review_01 = LectureReview.create(:lecture_id => 3, :region_id => 2, :title => '이것은 제목입니다.', :body => "질럿이 짱 먹는다 1")
      @review_02 = LectureReview.create(:lecture_id => 2, :region_id => 1, :title => '두번째 제목입니다. 정말로', :body => "뮤탈리스크 2")
      @review_03 = LectureReview.create(:lecture_id => 1, :region_id => 3, :title => '세번째 제목입니다. 정말로', :body => "우리집 강아지 이름은 가루. 밀가루의 가루. 가루가 짱먹는다 3")
    end
    
    it 'should search title' do
      LectureReview.make_it_filter('lecture_id-eq' => '2').should == [@review_02]
      LectureReview.make_it_filter('region_id-eq' => '3').should == [@review_03]
      
      
      LectureReview.make_it_filter(:title => '제목').count.should == 3
      LectureReview.make_it_filter(:title => '정말로').count.should == 2
    end
    
    it 'should search with multiple search options' do
      @review_03_1 = LectureReview.create(:lecture_id => 1, :region_id => 3, :title => '새로운 리뷰', :body => "3-1")
      @review_03_2 = LectureReview.create(:lecture_id => 1, :region_id => 9, :title => '새로운 리뷰2', :body => "3-2")
      
      LectureReview.make_it_filter('region_id-eq' => '3').count.should == 2
      LectureReview.make_it_filter('region_id-eq' => '3', 'title' => '새로운').count.should == 1
    end
    
    it 'should ignoring white space when searching korean' do
      LectureReview.make_it_filter(:title => '번째제목').count.should == 2
    end
    
    it 'should search title and body' do
      LectureReview.make_it_filter(:title => '정말로', :body => '뮤탈리스크').count.should == 1
      LectureReview.make_it_filter(:title => '제목', :body => '짱먹는다').count.should == 2
    end
  
    it 'should sort by region_id' do
      LectureReview.make_it_sort("region_id-asc").should == [@review_02, @review_01, @review_03]
      LectureReview.make_it_sort("region_id-desc").should == [@review_03, @review_01, @review_02]
      LectureReview.make_it_sort("lecture_id-asc").should == [@review_03, @review_02, @review_01]
    end
    
    it 'should sort to asc if no direction is provided' do
      LectureReview.make_it_sort("region_id").should == [@review_02, @review_01, @review_03]
    end
  end
  
end