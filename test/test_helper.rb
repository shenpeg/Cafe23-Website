require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "lib/tasks/"
  add_filter "lib/helpers/"
  add_filter "lib/filters/"
  add_filter "lib/exceptions.rb"
  add_filter "app/channels/application_cable/"
  add_filter "app/jobs/"
  add_filter "app/mailers/"
  add_filter "app/helpers/"
  add_filter "app/controllers/api/"
  add_filter "app/controllers/api_controller.rb"
  add_filter "app/serializers/"
end
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # Commented out b/c screwing with reporter
  # parallelize(workers: :number_of_processors)

  # Configure shoulda matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end

  # Add more helper methods to be used by all tests here...
  include Contexts

  # Add the infamous deny method...
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end

  # A method to login in an admin (or manager) to start things off
  def login_admin
    @alex = FactoryBot.create(:employee, first_name: "Alexander", username: "alexander", last_name: "Heimann", role: "admin")
    get login_path
    post sessions_path, params: { username: "alexander", password: "secret" }
  end

  def logout_admin
    get logout_path
  end

  def login_manager
    create_manager_context
    get login_path
    post sessions_path, params: { username: "ben", password: "secret" }
  end

  def login_employee
    create_employee_context
    get login_path
    post sessions_path, params: { username: "ralph", password: "secret" }
  end

  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end
