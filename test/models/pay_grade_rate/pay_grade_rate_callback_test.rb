require 'test_helper'

class PayGradeRateCallbackTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
      create_pay_grade_rates
    end
  
    should "end the current rate if it exists before adding a new rate for an employee" do
      assert_nil @c1_t2.end_date
      assert_equal @c1_t2, @c1.current_rate
      new_c1_rate = FactoryBot.create(:pay_grade_rate, pay_grade: @c1, start_date: Date.current, rate: 12.00)
      @c1_t2.reload
      assert_equal Date.current, @c1_t2.end_date
      assert_equal new_c1_rate, @c1.current_rate
    end

  end
end