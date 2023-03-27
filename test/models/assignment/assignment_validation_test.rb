require 'test_helper'

class AssignmentValidationTest < ActiveSupport::TestCase
  # Context
  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_pay_grade_rates
      create_assignments
    end

    should "allow for a end date in the past (or today) but after the start date" do
      # Note that we've been testing end_date: nil for a while now so safe to assume works...
      @assign_alex = FactoryBot.build(:assignment, employee: @alex, store: @oakland, pay_grade: @m2, start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date)
      assert @assign_alex.valid?
      @second_assignment_for_alex = FactoryBot.build(:assignment, employee: @alex, store: @oakland, pay_grade: @m2, start_date: 3.weeks.ago.to_date, end_date: Date.current)
      assert @second_assignment_for_alex.valid?
    end
    
    should "not allow for a end date in the future or before the start date" do
      # since Ed finished his last assignment a month ago, let's try to assign the lovable loser again ...
      second_assignment_for_ed = FactoryBot.build(:assignment, store: @oakland, employee: @ed, pay_grade: @c1, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.ago.to_date)
      deny second_assignment_for_ed.valid?
      third_assignment_for_ed = FactoryBot.build(:assignment, employee: @ed, store: @oakland, pay_grade: @c1, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.from_now.to_date)
      deny third_assignment_for_ed.valid?
    end
    
    should "identify a non-active store as part of an invalid assignment" do
      inactive_store = FactoryBot.build(:assignment, store: @hazelwood, employee: @ed, pay_grade: @c1, start_date: 1.day.ago.to_date, end_date: nil)
      deny inactive_store.valid?
    end

    should "identify a non-active pay_grade as part of an invalid assignment" do
      inactive_pay_grade = FactoryBot.build(:assignment, store: @hazelwood, employee: @ed, start_date: 1.day.ago.to_date, end_date: nil, pay_grade: @c0)
      deny inactive_pay_grade.valid?
    end
    
    should "identify a non-active employee as part of an invalid assignment" do
      @fred = FactoryBot.build(:employee, :first_name => "Fred", :active => false)
      inactive_employee = FactoryBot.build(:assignment, store: @oakland, employee: @fred, start_date: 1.day.ago.to_date, end_date: nil)
      deny inactive_employee.valid?
    end

  end
end
