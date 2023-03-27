require 'test_helper'

class ShiftValidationTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
    end

    # test validations
    should "only accept date data for date field" do
      @shift_kj_bad = FactoryBot.build(:shift, assignment: @assign_kathryn, date: "FRED")
      deny @shift_kj_bad.valid?
      @shift_kj_bad2 = FactoryBot.build(:shift, assignment: @assign_kathryn, date: "14:00:00")
      deny @shift_kj_bad2.valid?
      @shift_kj_bad3 = FactoryBot.build(:shift, assignment: @assign_kathryn, date: 2020)
      deny @shift_kj_bad3.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, date: 2.weeks.ago.to_date)
      assert @shift_kj_good.valid?
    end
    
    should "not allow date to be nil" do
      @shift_kj_bad = FactoryBot.build(:shift, assignment: @assign_kathryn, date: nil)
      deny @shift_kj_bad.valid?
    end
    
    should "ensure that shift dates do not precede the assignment start date" do
      @shift_kj_bad = FactoryBot.build(:shift, assignment: @assign_kathryn, date: 2.years.ago.to_date)
      deny @shift_kj_bad.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, date: 2.weeks.ago.to_date)
      assert @shift_kj_good.valid?
    end
    
    should "only accept time data for start time" do 
      @shift_kj_bad2 = FactoryBot.build(:shift, assignment: @assign_kathryn, start_time: "12:66")
      deny @shift_kj_bad2.valid?
      @shift_kj_bad3 = FactoryBot.build(:shift, assignment: @assign_kathryn, start_time: 2011)
      deny @shift_kj_bad3.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, start_time: Time.local(2000,1,1,12,0,0))
      assert @shift_kj_good.valid?
    end
    
    should "only accept time data for end time" do 
      @shift_kj_bad3 = FactoryBot.build(:shift, assignment: @assign_kathryn, end_time: 2020)
      deny @shift_kj_bad3.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, start_time: Time.local(2000,1,1,12,0,0), end_time: Time.local(2000,1,1,16,0,0))
      assert @shift_kj_good.valid?
    end
    
    should "not allow start time to be nil" do
      @shift_kj_bad = FactoryBot.build(:shift, assignment: @assign_kathryn, start_time: nil)
      deny @shift_kj_bad.valid?
    end
    
    should "allow end time can be nil" do
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, end_time: nil)
      assert @shift_kj_good.valid?
    end
    
    should "ensure that shift end times do not precede the shift start time" do
      @shift_kj_bad = FactoryBot.build(:shift, assignment: @assign_kathryn, end_time: Time.local(2000,1,1,10,0,0))
      deny @shift_kj_bad.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn, end_time: Time.local(2000,1,1,14,0,0))
      assert @shift_kj_good.valid?
    end
    
    should "ensure that shift are only given to current assignments" do
      @shift_ben_bad = FactoryBot.build(:shift, assignment: @assign_ben)
      deny @shift_ben_bad.valid?
      @shift_kj_good = FactoryBot.build(:shift, assignment: @assign_kathryn)
      assert @shift_kj_good.valid?
    end

  end
end
