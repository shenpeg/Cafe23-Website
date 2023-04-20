require 'test_helper'

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_all
  end

  test "should get store_form_path for admin" do
    get login_path
    post sessions_path, params: { username: "alex", password: "secret" }
    get store_form_path
    assert_response :success
  end

  test "should get store_form_path for manager" do
    get login_path
    post sessions_path, params: { username: "kathryn", password: "secret" }
    get store_form_path
    assert_response :success
  end

  test "should get employee_form_path for admin" do
    get login_path
    post sessions_path, params: { username: "alex", password: "secret" }
    get employee_form_path
    assert_response :success
  end

  test "should not get employee_form_path for manager" do
    get login_path
    post sessions_path, params: { username: "kathryn", password: "secret" }
    get employee_form_path
    assert_redirected_to home_path
  end

  test "should not get employee_form_path for manager with curr assignment" do
    assignment = Assignment.create(employee: @kathryn, store: @oakland, start_date: Date.today - 1.week, end_date: nil)
    get login_path
    post sessions_path, params: { username: "kathryn", password: "secret" }
    get employee_form_path
    assert_redirected_to home_path
  end

  test "should get an employee payroll report" do
    get login_path
    post sessions_path, params: { username: "alex", password: "secret" }
    get employee_payroll_path, params: { employee_id: @ralph.id, start_date: 7.days.ago.to_date, end_date: Date.current }
    assert_response :success
    assert_not_nil assigns(:employee_payroll)
  end

  test "should get a store payroll report for admin" do
    get login_path
    post sessions_path, params: { username: "alex", password: "secret" }
    get store_payroll_path, params: { store_id: @oakland.id, start_date: 7.days.ago.to_date, end_date: Date.current }
    assert_response :success
    assert_not_nil assigns(:store_payroll)
  end

  test "should get a store payroll report for manager" do
    get login_path
    post sessions_path, params: { username: "kathryn", password: "secret" }
    get store_payroll_path, params: { start_date: 7.days.ago.to_date, end_date: Date.current }
    assert_response :success
    assert_not_nil assigns(:store_payroll)
  end

  test "should not have generic routes (e.g., no index route)" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "payroll", action: "index") end
  end
end