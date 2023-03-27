require 'test_helper'

class AssignmentCallbackTest < ActiveSupport::TestCase
  # Context
  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_pay_grade_rates
      create_assignments
    end
    
    should "end the current assignment if it exists before adding a new assignment for an employee" do
      @promote_kathryn = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, pay_grade: @m2, start_date: 1.day.ago.to_date, end_date: nil)
      assert_equal 1.day.ago.to_date, @kathryn.assignments.first.end_date
      @promote_kathryn.destroy
    end

  end
end
