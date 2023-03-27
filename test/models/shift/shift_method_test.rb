require 'test_helper'

class ShiftMethodTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
    end
    
    # test report_completed? method
    should "have a report_completed? method that works properly" do
      create_jobs
      create_shift_jobs
      deny @shift_cindy.report_completed?
      assert @shift_ralph_2.report_completed?
      destroy_shift_jobs
      destroy_jobs
    end

    # test duration method
    should "have a method which calculates the duration of the shift, rounded to quarter-hours" do
      # test rounding up end_time
      assert_equal 3.0, @shift_kathryn.duration
      @shift_kathryn.end_time -= 1.minute
      assert_equal 3.0, @shift_kathryn.duration
      @shift_kathryn.end_time += 2.minute
      assert_equal 3.25, @shift_kathryn.duration
      @shift_kathryn.end_time += 12.minute
      assert_equal 3.25, @shift_kathryn.duration
      @shift_kathryn.end_time += 5.minute
      assert_equal 3.5, @shift_kathryn.duration
      # test rounding down start_time
      assert_equal 1.0, @shift_ralph_3.duration
      @shift_ralph_3.start_time += 2.minute
      assert_equal 1.0, @shift_ralph_3.duration
      @shift_ralph_3.start_time -= 5.minute
      assert_equal 1.25, @shift_ralph_3.duration
    end

  end
end
