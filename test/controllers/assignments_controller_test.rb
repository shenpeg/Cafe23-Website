require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @store = FactoryBot.create(:store)
    @employee = FactoryBot.create(:employee)
    @pay_grade = FactoryBot.create(:pay_grade)
    @assignment = FactoryBot.create(:assignment, store: @store, employee: @employee, pay_grade: @pay_grade)
  end

  test "should get index" do
    get assignments_path
    assert_response :success
    assert_not_nil assigns(:current_assignments)
    assert_not_nil assigns(:past_assignments)
  end

  test "should get show" do
    get assignment_path(@assignment)
    assert_response :success
  end

  test "should get new" do
    get new_assignment_path
    assert_response :success
  end

  test "should create assignment" do
    # create works
    assert_difference('Assignment.count') do
      @employee2 = FactoryBot.create(:employee, first_name: 'Fred', username: 'fred')
      post assignments_path, params: { assignment: { store_id: @store.id, employee_id: @employee2.id, start_date: Date.yesterday, end_date: nil, pay_grade_id: @pay_grade.id } }
    end
    assert_equal "Successfully added the assignment.", flash[:notice]
    assert_redirected_to assignments_path

    # create fails
    post assignments_path, params: { assignment: { store_id: @store.id, employee_id: nil, start_date: Date.yesterday, end_date: nil, pay_grade_id: @pay_grade.id } }
    assert_template :new
  end

  test "should get edit" do
    get edit_assignment_path(@assignment)
    assert_response :success
  end

  test "should update assignment" do
    # update works
    patch assignment_path(@assignment), params: { assignment: { store_id: @store.id, employee_id: @employee.id, start_date: Date.yesterday, end_date: nil, pay_grade_id: @pay_grade.id } }
    assert_equal "Updated assignment information.", flash[:notice]
    assert_redirected_to assignments_path

    # update fails
    patch assignment_path(@assignment), params: { assignment: { store_id: nil, employee_id: @employee.id, start_date: Date.yesterday, end_date: nil, pay_grade_id: @pay_grade.id } }
    assert_template :edit
  end

  test "should destroy assignment when appropriate" do
    assert_difference('Assignment.count', -1) do
      delete assignment_path(@assignment)
    end
    assert_equal "Removed assignment from the system.", flash[:notice]
    assert_redirected_to assignments_path
  end

  # These are phase 4 tests only...
  test "should get index for employee" do
    logout_admin
    login_employee
    get assignments_path
    assert_response :success
    # more than we might usually do in a controller test, but good experience...
    assert assigns(:current_assignments).include?(@assign_ralph_2)
    deny assigns(:current_assignments).include?(@assign_ed_2)
    assert assigns(:past_assignments).include?(@assign_ralph)
    deny assigns(:past_assignments).include?(@assign_ed)
  end

  test "should not destroy assignment when in appropriate" do
    assignment2 = FactoryBot.create(:assignment, store: @store, employee: @employee, pay_grade: @pay_grade, start_date: 4.days.ago.to_date, end_date: nil)
    shift = FactoryBot.create(:shift, assignment: assignment2, date: 3.days.ago.to_date, status: 'finished')
    assert_difference('Assignment.count', 0) do
      delete assignment_path(assignment2)
    end
    assert_template :show
  end

end

