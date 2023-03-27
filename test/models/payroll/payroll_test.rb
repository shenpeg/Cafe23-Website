require 'test_helper'

class PayrollTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_employees
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
    end

    should "have properly created accessor methods" do
      kathryn_pay = Payroll.new(@kathryn)
      assert kathryn_pay.respond_to?(:employee)
      assert kathryn_pay.respond_to?(:employee_name)
      assert kathryn_pay.respond_to?(:ssn)
      assert kathryn_pay.respond_to?(:pay_grade)
      assert kathryn_pay.respond_to?(:pay_rate)
      assert kathryn_pay.respond_to?(:hours)
      assert kathryn_pay.respond_to?(:pay_earned)
      assert kathryn_pay.respond_to?(:hours=)
      assert kathryn_pay.respond_to?(:pay_earned=)
      assert kathryn_pay.respond_to?(:pay_grade=)
      assert kathryn_pay.respond_to?(:pay_rate=)
      assert !kathryn_pay.respond_to?(:employee=)
      assert !kathryn_pay.respond_to?(:employee_name=)
      assert !kathryn_pay.respond_to?(:ssn=)
    end

    should "initialize properly for an employee" do
      kathryn_pay = Payroll.new(@kathryn)
      assert_equal @kathryn, kathryn_pay.employee
      assert_equal "Janeway, Kathryn", kathryn_pay.employee_name
      assert_equal "082869198", kathryn_pay.ssn
      assert_nil   kathryn_pay.pay_grade
      assert_nil   kathryn_pay.pay_rate
      assert_equal 0.0, kathryn_pay.hours
      assert_equal 0.0, kathryn_pay.pay_earned
    end

  end
end