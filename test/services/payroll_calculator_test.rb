require 'test_helper'

class PayrollCalculatorTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_employees
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      create_shifts
      # a shift that starts 2 minutes late and finishes 3 minutes early to test rounding rules
      @shift_kathryn_yesterday = FactoryBot.create(:shift, assignment: @assign_kathryn, date: 1.day.ago.to_date, start_time: Time.local(2000,1,1,13,2,0,), end_time: Time.local(2000,1,1,16,58,0,))
      @calculator = PayrollCalculator.new(DateRange.new(4.days.ago.to_date, 1.day.ago.to_date))
    end
  

    should "have properly created accessor methods" do
      assert @calculator.respond_to?(:date_range)
      assert @calculator.respond_to?(:start_date)
      assert @calculator.respond_to?(:end_date)
      assert @calculator.respond_to?(:payrolls)
      assert @calculator.respond_to?(:payrolls=)
      assert !@calculator.respond_to?(:date_range=)
      assert !@calculator.respond_to?(:start_date=)
      assert !@calculator.respond_to?(:end_date=)
    end

    should "create a list of payroll objects for a given store and date range" do
      payroll = @calculator.create_payrolls_for(@oakland)
      assert_equal 4.days.ago.to_date, @calculator.start_date
      assert_equal 1.day.ago.to_date, @calculator.end_date
      assert_equal 2, payroll.count  # four shifts total, but only two payrolls
      # note that Kathryn's shift created second, but list alphabetized by employee...
      assert_equal "Janeway, Kathryn", payroll.first.employee_name
      assert_equal "M1", payroll.first.pay_grade
      assert_equal 20.75, payroll.first.pay_rate
      assert_equal 4, payroll.first.hours # one shift of 4 hours; rounding tested here
      assert_equal 83, payroll.first.pay_earned
      assert_equal "Wilson, Ralph", payroll.last.employee_name
      assert_equal "C1", payroll.last.pay_grade
      assert_equal 9.75, payroll.last.pay_rate
      assert_equal 8, payroll.last.hours # three shifts of 3, 4, and 1 hour
      assert_equal 78, payroll.last.pay_earned

    end

    should "return a payroll object for a given employee and date range" do
      # employee with single shift tested (and rounding of times)
      payroll_kathryn = @calculator.create_payroll_record_for(@kathryn)
      assert_equal "Janeway, Kathryn", payroll_kathryn.employee_name
      assert_equal "M1", payroll_kathryn.pay_grade
      assert_equal 20.75, payroll_kathryn.pay_rate
      assert_equal 4, payroll_kathryn.hours # one shift of 4 hours; rounding tested here
      assert_equal 83, payroll_kathryn.pay_earned

      # employee with multiple shifts tested
      payroll_ralph = @calculator.create_payroll_record_for(@ralph)
      assert_equal "Wilson, Ralph", payroll_ralph.employee_name, "PO: #{payroll_ralph.inspect}"
      assert_equal "C1", payroll_ralph.pay_grade
      assert_equal 9.75, payroll_ralph.pay_rate
      assert_equal 8, payroll_ralph.hours # three shifts of 3, 4, and 1 hour
      assert_equal 78, payroll_ralph.pay_earned

      # employee with no shifts tested
      payroll_ben = @calculator.create_payroll_record_for(@ben)
      assert_equal "Sisko, Ben", payroll_ben.employee_name
      assert_equal "M2", payroll_ben.pay_grade
      assert_equal 25.00, payroll_ben.pay_rate
      assert_equal 0.0, payroll_ben.hours # no shifts, so no hours
      assert_equal 0.0, payroll_ben.pay_earned # and hence, no pay 
    end

  end
end