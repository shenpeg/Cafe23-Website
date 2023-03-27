require 'test_helper'

class PayGradeRateValidationTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
      create_pay_grade_rates
    end
  
    should "not allow rates to be created for inactive pay grades" do
      deny @c0.active
      @rate_for_inactive_pay_grade = FactoryBot.build(:pay_grade_rate, pay_grade: @c0, rate: 7.75, start_date: 24.months.ago.to_date)
      deny @rate_for_inactive_pay_grade.valid?
    end

    should "not allow rates to be created for non-existence pay grades" do
      ghost_grade = FactoryBot.build(:pay_grade, level: "Ghost")
      @rate_for_nonexistent_pay_grade = FactoryBot.build(:pay_grade_rate, pay_grade: ghost_grade, rate: 7.75, start_date: 24.months.ago.to_date)
      deny @rate_for_nonexistent_pay_grade.valid?
    end

  end
end
