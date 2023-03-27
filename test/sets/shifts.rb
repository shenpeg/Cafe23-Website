module Contexts
  module Shifts

    def create_shifts
      # many shifts for Ralph
      @shift_ralph_1 = FactoryBot.create(:shift, assignment: @assign_ralph, date: 3.days.ago.to_date, status: 3)
      @shift_ralph_2 = FactoryBot.create(:shift, assignment: @assign_ralph, date: 2.days.ago.to_date, start_time: Time.local(2000,1,1,12,0,0,), end_time: Time.local(2000,1,1,16,0,0,), status: 3)
      @shift_ralph_3 = FactoryBot.create(:shift, assignment: @assign_ralph, date: 1.day.ago.to_date, start_time: Time.local(2000,1,1,13,0,0,), end_time: Time.local(2000,1,1,14,0,0,), status: 3)
      @shift_ralph_4 = FactoryBot.create(:shift, assignment: @assign_ralph, date: Date.current, start_time: Time.local(2000,1,1,13,0,0,))

      # future shifts
      @shift_cindy = FactoryBot.create(:shift, assignment: @assign_cindy, date: 1.day.from_now.to_date)

      # manager shifts (started, but not finished)
      @shift_kathryn = FactoryBot.create(:shift, assignment: @assign_kathryn, status: 2)
    end
    
    def destroy_shifts
      @shift_ralph_4.destroy
      @shift_ralph_3.destroy
      @shift_ralph_2.destroy
      @shift_ralph_1.destroy
      @shift_cindy.destroy
      @shift_kathryn.destroy
    end

  end
end


