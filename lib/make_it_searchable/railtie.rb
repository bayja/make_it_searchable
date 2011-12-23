# encoding: utf-8

module MakeItSearchable
  class Railtie < Rails::Railtie

    initializer 'make_it_searchable' do
      ActiveSupport.on_load :active_record do
        extend ClassMethods
        extend Validator
        extend GenerateQuery
      end
    end
    
    initializer 'make_it_searchable.view_helper' do
      ActionView::Base.send :include, ViewHelper
    end
    
  end
end