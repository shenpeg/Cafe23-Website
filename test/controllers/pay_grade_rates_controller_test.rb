require 'test_helper'

class PayGradeRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @pay_grade = FactoryBot.create(:pay_grade)
  end

  test "should get new" do
    get new_pay_grade_rate_path(pay_grade_id: @pay_grade.id)
    assert_response :success
  end

  test "should create new pay grade rate" do
    assert_difference('PayGradeRate.count') do
      post pay_grade_rates_path, params: { pay_grade_rate: { pay_grade_id: @pay_grade.id, rate: 7.75, start_date: 12.months.ago.to_date, end_date: nil  } }
    end
    assert_redirected_to pay_grade_path(PayGradeRate.last.pay_grade)

    post pay_grade_rates_path, params: { pay_grade_rate: { pay_grade_id: @pay_grade.id, rate: nil, start_date: 12.months.ago.to_date, end_date: nil } }
    assert_template :new
  end

  test "should not have generic routes (i.e., not using resources :pay_grade_routes)" do
    @pay_grade_rate = FactoryBot.create(:pay_grade_rate, pay_grade: @pay_grade)
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grade_rate", action: "index") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grade_rate", action: "show", id: "#{@pay_grade_rate.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grade_rate", action: "edit", id: "#{@pay_grade_rate.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grade_rate", action: "update", id: "#{@pay_grade_rate.id}") end
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "pay_grade_rate", action: "destroy", id: "#{@pay_grade_rate.id}") end
  end

end


