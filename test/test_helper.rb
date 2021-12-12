# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

require 'simplecov'            # These two lines must go first
SimpleCov.start

require 'minitest/autorun'     # Sets up minitest
                               # You could require other shared gems here, too
module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    ActiveRecord::Base.subclasses.each(&:delete_all)
  end
end
