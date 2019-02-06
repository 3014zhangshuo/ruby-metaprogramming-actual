# class UserMailer < ApplicationMailer
#   def welcome(user)
#   end
# end
#
# UserMailer.welcome(user).deliver_later

class Mailer
  def deliver_later
    p 'deliver later'
  end

  class << self
    def method_missing(method_name, *args)
      new.send(method_name, *args)
    end
  end
end

class UserMailer < Mailer
  def welcome(user)
    p "welcome #{user}"
    self
  end
end

UserMailer.welcome('zhangshuo').deliver_later

################################################################################

# class UserWorker
#   include Sidekiq::Worker
#
#   def perform
#   end
# end
#
# UserWorker.perform_later

require 'active_support/all'

module Worker
  extend ActiveSupport::Concern

  class_methods do
    def perform_later
      self.new.perform
    end
  end
end

class UserWorker
  include Worker

  def perform
    p 'perform in Worker'
  end
end

UserWorker.perform_later
