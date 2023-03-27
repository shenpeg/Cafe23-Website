require 'test_helper'

class Handling404ApplicationControllerTest < ActionDispatch::IntegrationTest

  # A test to make sure the application controller is handling 
  # 404 errors in a reasonable manner.
  setup do
    login_admin
    create_employee_context
  end

  test "a 404 error is adequately handled by the system." do
    get employee_path(999)
    assert_equal "We apologize, but this information could not be found.", flash[:error]
    assert_redirected_to home_path
  end

end