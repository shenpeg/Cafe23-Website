require 'test_helper'

class JobDeletionTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_jobs
    end

    should "allow jobs with no associated shifts to be destroyed" do
      assert @cashier.shift_jobs.empty?
      assert @cashier.destroy
    end
    
    should "not allow jobs with associated shifts to be destroyed" do
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
      create_shift_jobs
      deny @cashier.shift_jobs.empty?
      deny @cashier.destroy
    end

  end
end
