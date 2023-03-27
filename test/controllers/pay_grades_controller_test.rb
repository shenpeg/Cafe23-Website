require 'test_helper'

class PayGradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @pay_grade = FactoryBot.create(:pay_grade)
  end

  test "should get index" do
    get pay_grades_path
    assert_response :success
  end

  test "should get show" do
    get pay_grade_path(@pay_grade)
    assert_response :success
    assert_not_nil assigns(:pay_grade_rate_history)
  end

  test "should get new" do
    get new_pay_grade_path
    assert_response :success
  end

  test "should get edit" do
    get edit_pay_grade_path(@pay_grade)
    assert_response :success
  end

  test "should create pay_grade" do
    assert_difference('PayGrade.count') do
      post pay_grades_path, params: { pay_grade: { level: 'X1', active: true  } }
    end
    assert_redirected_to pay_grades_path

    post pay_grades_path, params: { pay_grade: { level: nil, active: true  } }
    assert_template :new
  end

  test "should update pay_grade" do
    patch pay_grade_path(@pay_grade), params: { pay_grade: { level: @pay_grade.level, active: false  } }
    assert_redirected_to pay_grades_path

    patch pay_grade_path(@pay_grade), params: { pay_grade: { level: nil, active: false  } }
    assert_template :edit
  end

  test "should be no destroy action for pay_grade" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grades", action: "destroy", id: "#{@pay_grade.id}") end
  end

end
