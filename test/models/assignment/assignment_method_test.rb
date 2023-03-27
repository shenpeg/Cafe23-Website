require 'test_helper'

class AssignmentMethodTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
    end

    should "terminate an assignment effectively as of today" do
      create_shifts
      # precondition: an active assignment with a pending shift
      assert_nil @assign_cindy.end_date
      assert_equal 1, @assign_cindy.shifts.pending.count
      @assign_cindy.terminate
      @assign_cindy.reload
      # postcondition: an ended assignment with no pending shifts
      assert_equal Date.current, @assign_cindy.end_date
      assert_equal 0, @assign_cindy.shifts.pending.count
    end

    should "not terminate a completed assignment" do
      assert_equal 6.months.ago.to_date, @assign_ben.end_date
      @assign_ben.terminate
      assert_equal 6.months.ago.to_date, @assign_ben.end_date
    end
  
  end
end
