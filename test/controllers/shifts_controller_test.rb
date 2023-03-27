require "test_helper"

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @store      = FactoryBot.create(:store)
    @employee   = FactoryBot.create(:employee)
    @pay_grade  = FactoryBot.create(:pay_grade)
    @assignment = FactoryBot.create(:assignment, store: @store, employee: @employee, pay_grade: @pay_grade, start_date: 7.days.ago.to_date, end_date: nil)
    @shift      = FactoryBot.create(:shift, assignment: @assignment, date: 3.days.ago.to_date, status: 'finished')
    @starts     = Time.local(2000,1,1,11,0,0)
    @ends       = Time.local(2000,1,1,14,0,0)
  end

  test "should get index" do
    get shifts_path
    assert_response :success
  end

  test "should show shift" do
    get shift_path(@shift)
    assert_response :success
  end

  test "should get new" do
    get new_shift_path
    assert_response :success
  end

  test "should create shift" do
    # create works
    assert_difference('Shift.count') do
      post shifts_path, params: { shift: { assignment_id: @assignment.id, date: Date.current, start_time: @starts, end_time: @ends, notes: nil, status: 'pending' } }
    end
    assert_redirected_to shift_path(Shift.last)

    # create fails
    post shifts_path, params: { shift: { assignment_id: @assignment.id, date: nil, start_time: @starts, end_time: @ends, notes: nil, status: 'pending' } }
    assert_template :new
  end

  test "should get edit" do
    get edit_shift_path(@shift)
    assert_response :success
  end

  test "should update shift" do
    # update works
    patch shift_path(@shift), params: { shift: { assignment_id: @assignment.id, date: @shift.date, start_time: @shift.start_time, end_time: @shift.end_time, notes: 'Truly glorious', status: 'finished' } }
    assert_redirected_to shift_path(@shift)

    # update fails
    patch shift_path(@shift), params: { shift: { assignment_id: @assignment.id, date: nil, start_time: @shift.start_time, end_time: @shift.end_time, notes: 'Truly glorious', status: 'finished' } }
    assert_template :edit
  end

  test "should destroy shift when appropriate" do
    @future_shift = FactoryBot.create(:shift, assignment: @assignment, date: Date.tomorrow, status: 'pending')
    assert_difference('Shift.count', -1) do
      delete shift_path(@future_shift)
    end
    assert_redirected_to shifts_path
  end

  test "should not destroy shift when inappropriate" do
    @past_shift = FactoryBot.create(:shift, assignment: @assignment, date: Date.yesterday, status: 'finished')
    assert_difference('Shift.count', 0) do
      delete shift_path(@past_shift)
    end
    assert_template :show
  end

  test "should go to the time clock view if current_user has a shift today" do
    logout_admin
    login_employee
    shift_today_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.current, start_time: Time.local(2000,1,1,13,0,0,), end_time: nil)
    get time_clock_path
    assert_response :success
    assert_not_nil assigns(:shift_today)
  end

  test "should not go to the time clock view if current_user doesn't have a shift today" do
    logout_admin
    login_employee
    shift_tomorrow_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.tomorrow, start_time: Time.local(2000,1,1,13,0,0,), end_time: nil)
    get time_clock_path
    assert_equal "You do not have any shifts today", flash[:notice]
    assert_redirected_to home_path
  end

  test "should be able to clock in for a shift today" do
    logout_admin
    login_employee
    shift_today_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.current, start_time: Time.local(2000,1,1,(Time.now.hour),0,0,), end_time: nil)
    patch time_in_path
    assert_equal "Your shift has started.", flash[:notice]
    assert_redirected_to home_path
  end

  test "should not be able to clock in for a shift tomorrow" do
    logout_admin
    login_employee
    shift_tommorrow_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.tomorrow, start_time: Time.local(2000,1,1,(Time.now.hour),0,0,), end_time: nil)
    patch time_in_path
    assert_equal "You do not have any shifts today", flash[:notice]
    assert_redirected_to home_path
  end

  test "should be able to clock out for a shift today" do
    logout_admin
    login_employee
    shift_today_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.current, start_time: Time.local(2000,1,1,(Time.now.hour),0,0,), end_time: nil, status: 2)
    patch time_out_path
    assert_equal "Your shift has ended.", flash[:notice]
    assert_redirected_to home_path
  end

  test "should not be able to clock out for a shift tomorrow" do
    logout_admin
    login_employee
    shift_tommorrow_for_ralph = FactoryBot.create(:shift, assignment: @assign_ralph_2, date: Date.tomorrow, start_time: Time.local(2000,1,1,(Time.now.hour),0,0,), end_time: nil)
    patch time_out_path
    assert_equal "You do not have any shifts today", flash[:notice]
    assert_redirected_to home_path
  end
end
