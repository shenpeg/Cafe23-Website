require 'test_helper'

class ShiftCallbackTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
    end
    
    # test callback to see that end_time is set to 3 hours afterwards
    should "have a callback which sets end time to three hours on create, but not on update" do
      # end_time is set on create
      @shift_kj_good = FactoryBot.create(:shift, assignment: @assign_kathryn, start_time: Time.local(2000,1,1,14,0,0), end_time: nil)
      assert_equal "17:00:00", @shift_kj_good.end_time.strftime("%H:%M:%S")
      # end_time is left alone on update
      assert_equal "14:00:00", @shift_kathryn.end_time.strftime("%H:%M:%S")
      @shift_kathryn.notes = "She did a good job today."
      @shift_kathryn.start_time = Time.local(2000,1,1,12,0,0)
      @shift_kathryn.save!
      assert_equal "14:00:00", @shift_kathryn.end_time.strftime("%H:%M:%S")
      # test end_date not defaulted if set to some value
      @shift_kj_long = FactoryBot.create(:shift, assignment: @assign_kathryn, start_time: Time.local(2000,1,1,12,0,0), end_time: Time.local(2000,1,1,22,0,0))
      assert_equal "22:00:00", @shift_kj_long.end_time.strftime("%H:%M:%S")
    end

  end
end
