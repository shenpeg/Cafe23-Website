require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @employee = FactoryBot.create(:employee)
  end

  test "should get index" do
    get employees_path
    assert_response :success
    assert_not_nil assigns(:active_employees)
    assert_not_nil assigns(:inactive_employees)
  end

  test "should show employee" do
    store = FactoryBot.create(:store)
    pay_grade = FactoryBot.create(:pay_grade)
    assign = FactoryBot.create(:assignment, employee: @employee, store: store, pay_grade: pay_grade, end_date: nil)
    get employee_path(@employee)
    assert_response :success
    assert_not_nil assigns(:current_assignment)
    assert_not_nil assigns(:other_assignments)
  end

  test "should get new" do
    get new_employee_path
    assert_response :success
  end

  test "should create employee" do
    # create works
    assert_difference('Employee.count') do
      post employees_path, params: { employee: { first_name: 'Ezra', last_name: 'Bridger',  ssn: '037201234', phone: '4122683259', date_of_birth: 19.years.ago.to_date, role: 'employee', username: 'ezra', password: 'secret', password_confirmation: 'secret',  active: true } }
    end
    assert_equal "Successfully added Ezra Bridger as an employee.", flash[:notice]
    assert_redirected_to employee_path(Employee.last)

    # create fails
    post employees_path, params: { employee: { first_name: nil, last_name: 'Bridger',  ssn: '037201234', phone: '4122683259', date_of_birth: 19.years.ago.to_date, role: 'employee', username: 'ezra', password: 'secret', password_confirmation: 'secret',  active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_employee_path(@employee)
    assert_response :success
  end

  test "should update employee" do
    # update works
    patch employee_path(@employee), params: { employee: { first_name: 'Mark', last_name: 'Heimann',  ssn: '037201234', phone: '4122683259', date_of_birth: 26.years.ago.to_date, role: 'employee', username: 'mark', password: 'secret', password_confirmation: 'secret',  active: true } }
    assert_equal "Updated Mark Heimann's information.", flash[:notice]
    assert_redirected_to employee_path(@employee)

    # update fails
    patch employee_path(@employee), params: { employee: { first_name: 'Mark', last_name: nil,  ssn: '037201234', phone: '4122683259', date_of_birth: 26.years.ago.to_date, role: 'employee', username: 'mark', password: 'secret', password_confirmation: 'secret',  active: true } }
    assert_template :edit
  end

  # These are phase 4 tests only...
  test "should get index for manager" do
    logout_admin
    login_manager
    get employees_path
    assert_response :success
    # more than we might usually do in a controller test, but good experience...
    assert assigns(:active_employees).include?(@ralph)
    deny assigns(:active_employees).include?(@ed)
    assert assigns(:inactive_employees).empty?

  end

  test "should destroy employee when appropriate" do
    assert_difference('Employee.count', -1) do
      delete employee_path(@employee)
    end
    assert_redirected_to employees_path
  end

  test "should not destroy employee when inappropriate" do
    store     = FactoryBot.create(:store)
    pay_grade = FactoryBot.create(:pay_grade)
    assign    = FactoryBot.create(:assignment, employee: @employee, store: store, pay_grade: pay_grade, end_date: nil)
    shift     = FactoryBot.create(:shift, assignment: assign, date: 3.days.ago.to_date, status: 'finished')
    
    assert_difference('Employee.count', 0) do
      delete employee_path(@employee)
    end
    assert_template :show
  end

end
