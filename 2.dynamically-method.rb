require 'active_support/all'

module ActsAsField
  def self.included(base)
    base.send :extend, ClassMethods

    base.class_eval do
      cattr_accessor :acts_as_fields
      self.acts_as_fields = []
    end
  end

  module ClassMethods
    def field(name, source)
      self.acts_as_fields << name

      define_method(name) do
        if source.is_a?(Proc)
          source.call(self)
        else
          source.split('.').inject(self.raw_data) { |hash, key| hash[key] }
        end
      end
    end
  end
end

class Product
  include ActsAsField

  field :title, "data.title"
  field :power, "meta.power"
  field :duration, "meta.duration"
  field :power_usgae, proc { |record| record.power / record.duration }

  def raw_data
    {
      "data" => {
        "title" => "swith 1"
      },
      "meta" => {
        "power" => 200,
        "duration" => 20
      }
    }
  end
end

product = Product.new
p product.title
p product.power
p product.power_usgae
p Product.acts_as_fields
