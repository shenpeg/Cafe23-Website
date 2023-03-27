require 'test_helper'

class EmployeeDeletionTest < ActiveSupport::TestCase
  context "Given context" do
    setup do 
      create_employees
    end

    should "allow employees who have yet to work a shift to be destroyed" do
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      create_shifts
      deny @cindy.shifts.upcoming.empty?
      assert @cindy.shifts.past.empty?
      current_assignment_id = @cindy.current_assignment.id
      current_shifts_ids = @cindy.shifts.map(&:id)
      assert @cindy.destroy
      assert_raise ActiveRecord::RecordNotFound do Assignment.find(current_assignment_id); end
      current_shifts_ids.each do |shift_id|
        assert_raise ActiveRecord::RecordNotFound do Shift.find(shift_id); end
      end
    end

    should "not allow employees who have worked a shift to be destroyed" do
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      create_shifts
      assert @ralph.active
      deny @ralph.shifts.finished.empty?
      deny @ralph.shifts.pending.empty?
      deny @ralph.destroy
      @ralph.reload
      # deny @ralph.active
      # assert @ralph.shifts.pending.empty?
      # deny @ralph.shifts.finished.empty?
      # assert_nil @ralph.current_assignment
    end

    should "not allow an improper edit of employee to kick in deletion protocols" do
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      create_shifts
      # preconditions
      assert @ralph.active
      deny @ralph.shifts.pending.empty?
      refute_nil @ralph.current_assignment
      # bad edit that will force a rollback
      @ralph.first_name = nil
      @ralph.save
      @ralph.reload
      # postcondition: still has an active status, current assignment and pending shifts
      assert @ralph.active
      deny @ralph.shifts.pending.empty?
      refute_nil @ralph.current_assignment
    end

  end
end
