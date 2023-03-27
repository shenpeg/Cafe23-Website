require 'test_helper'

class AssignmentDeletionTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
    end

    should "allow assignments with no shifts to be destroyed" do
      assert @promote_ben.shifts.empty?
      assert @promote_ben.destroy
    end

    should "allow assignments with only pending shifts to be destroyed" do
      create_shifts
      deny @assign_cindy.shifts.pending.empty?
      assert @assign_cindy.shifts.started.empty?
      assert @assign_cindy.shifts.finished.empty?
      assert @assign_cindy.destroy
    end
    
    should "not allow assignments with non-pending shifts to be destroyed" do
      create_shifts
      # assignments with finished shifts cannot be destroyed
      deny @assign_ralph.shifts.finished.empty?
      deny @assign_ralph.destroy
      # assignments with started (but not finished) shifts also can't be destroyed
      assert @assign_kathryn.shifts.finished.empty?
      deny @assign_kathryn.shifts.started.empty?
      deny @assign_kathryn.destroy
    end
  end
end
