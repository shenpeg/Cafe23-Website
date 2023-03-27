require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest

  test "should redirect to home path on authorization failure" do
    login_manager
    get pay_grades_path
    assert_redirected_to home_path
  end

  test "should redirect to home path on 404 errors" do
    login_admin
    get store_path(1)
    assert_redirected_to home_path
  end

  test "should create a current user" do
    login_admin
    assert_equal 'Alexander', @controller.send(:current_user).first_name
  end

  test "should have a logged_in? method" do
    login_admin
    assert @controller.send(:logged_in?)
  end

  test "should have a check_login method" do
    @store = FactoryBot.create(:store)    # something there, so no 404
    get stores_path                       # but not logged in yet
    assert_redirected_to login_path
  end

end