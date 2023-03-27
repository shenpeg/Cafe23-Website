require 'test_helper'

class EmployeePaymentTest < ActiveSupport::TestCase
  context "Given context" do
    setup do 
      create_employees
    end

    # test the method 'current_pay_grade'
    should "shows return employee's current pay grade as a string, if it exists" do
      create_stores
      create_pay_grades
      create_assignments
      assert_equal "M1", @kathryn.current_pay_grade
      assert_nil @alex.current_pay_grade
      destroy_assignments
      destroy_pay_grades
      destroy_stores
    end

    # test the method 'current_pay_rate'
    should "shows return employee's current pay rate as a float, if it exists" do
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      assert_equal 20.75, @kathryn.current_pay_rate
      assert_equal 25.00, @ben.current_pay_rate
      assert_nil @alex.current_pay_rate
      destroy_assignments
      destroy_pay_grade_rates
      destroy_pay_grades
      destroy_stores
    end

    # test the method 'pay_grade_on(date)'
    should "shows return employee's pay grade on a given date as a string, if it exists" do
      create_stores
      create_pay_grades
      create_assignments
      assert_equal "M1", @ben.pay_grade_on(1.year.ago.to_date)
      assert_equal "M2", @ben.pay_grade_on(3.months.ago.to_date)
      assert_nil @alex.pay_grade_on(3.months.ago.to_date)
      destroy_assignments
      destroy_pay_grades
      destroy_stores
    end

    # test the method 'pay_rate_on(date)'
    should "shows return employee's pay rate on a given date as a float, if it exists" do
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      assert_equal 19.75, @ben.pay_rate_on(22.months.ago.to_date)
      assert_equal 20.75, @ben.pay_rate_on(8.months.ago.to_date)
      assert_equal 25.00, @ben.pay_rate_on(3.months.ago.to_date)
      assert_nil @alex.pay_rate_on(3.months.ago.to_date)
      destroy_assignments
      destroy_pay_grade_rates
      destroy_pay_grades
      destroy_stores
    end
  end
end
