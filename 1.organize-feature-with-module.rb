require 'active_support/all'

class Product
end

module Searching
  module Query
    def self.define model, &block
      klass = model.to_s_constantize
      klass.instance_eval(&block)

      klass.extend ClassMethods
    end
  end

  module ClassMethods
    def search
    end

    def sort
    end
  end
end

# app/indices/production_indexer.rb
Searching::Query.define :Product do
  def sort
  end

  def search
  end
end
