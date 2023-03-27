require 'test_helper'

class ShiftJobScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
      create_jobs
      create_shift_jobs
    end

    should "list shift jobs alphabetically by job" do
      assert_equal ['Barista', 'Cashier', 'Cashier'], ShiftJob.alphabetical.map{|sj| sj.job.name}.sort
    end

  end
end
