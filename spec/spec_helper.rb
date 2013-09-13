require "rubygems"
require "spork"

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)

  require "rspec/rails"
  require "rspec/autorun"
  require "pry"

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.order = "random"
    config.include Html
  end
end

Spork.each_run do
  require "rails-bootstrap-helpers"
end