require 'test_helper'

class ShiftDeletionTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
    end

    should "allow shifts that are pending to be destroyed" do
      assert @shift_cindy.status == 'pending'
      assert @shift_cindy.destroy
    end
    
    should "not allow shifts that have started or finished to be destroyed" do
      deny @shift_ralph_1.status == 'pending'
      deny @shift_ralph_1.destroy
    end

  end
end
