require 'test_helper'

class TimeClockTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_employees
      create_stores
      create_pay_grades
      create_pay_grade_rates
      create_assignments
      create_shifts
      @start_time_clock = TimeClock.new(@shift_ralph_4)
    end
    
    should "have properly created accessor methods" do
      assert @start_time_clock.respond_to?(:shift)
      assert !@start_time_clock.respond_to?(:shift=)
    end

    should "properly start a shift" do
      assert_equal "pending", @shift_ralph_4.status
      assert_equal 13, @shift_ralph_4.start_time.hour
      assert_equal 0, @shift_ralph_4.start_time.min
      @start_time_clock.start_shift_at(Time.local(2000,1,1, 12, 45, 0))
      @shift_ralph_4.reload
      assert_equal "started", @shift_ralph_4.status
      assert_equal 12, @shift_ralph_4.start_time.hour
      assert_equal 45, @shift_ralph_4.start_time.min      
    end

    should "properly end a shift" do
      assert_equal "started", @shift_kathryn.status
      assert_equal 14, @shift_kathryn.end_time.hour
      assert_equal 0, @shift_kathryn.end_time.min
      end_time_clock = TimeClock.new(@shift_kathryn)
      end_time_clock.end_shift_at(Time.local(2000,1,1, 15, 30, 0))
      @shift_kathryn.reload
      assert_equal "finished", @shift_kathryn.status
      assert_equal 15, @shift_kathryn.end_time.hour
      assert_equal 30, @shift_kathryn.end_time.min      
    end

    should "start a shift at the current time" do
      assert @shift_ralph_4.pending?
      assert_equal 13, @shift_ralph_4.start_time.hour
      assert_equal 0, @shift_ralph_4.start_time.min
      @start_time_clock.start_shift_at()
      @shift_ralph_4.reload
      assert @shift_ralph_4.started?
      assert_equal Time.now.hour, @shift_ralph_4.start_time.hour
      assert_equal Time.now.min, @shift_ralph_4.start_time.min 
    end

    should "end a shift at the current time" do
      shift_cindy_2 = FactoryBot.create(:shift, assignment: @assign_cindy, date: Date.current, start_time: 1.hour.ago, end_time: 1.hour.from_now, status: 2)
      assert shift_cindy_2.started?
      end_time_clock = TimeClock.new(shift_cindy_2)
      end_time_clock.end_shift_at()
      assert shift_cindy_2.finished?
      assert_equal Time.now.hour, shift_cindy_2.end_time.hour
      assert_equal Time.now.min, shift_cindy_2.end_time.min
    end

    should "not start a shift that has already started or finished" do
      assert @shift_kathryn.started?
      start_time_clock = TimeClock.new(@shift_kathryn)
      deny start_time_clock.start_shift_at()
      assert @shift_ralph_1.finished?
      time_clock_2 = TimeClock.new(@shift_ralph_1)
      deny time_clock_2.start_shift_at()
    end

    should "not end a shift that is either pending or finished" do
      assert @shift_ralph_4.pending?
      time_clock_1 = TimeClock.new(@shift_ralph_4)
      deny time_clock_1.end_shift_at()
      assert @shift_ralph_1.finished?
      time_clock_2 = TimeClock.new(@shift_ralph_1)
      deny time_clock_2.end_shift_at()
    end

  end
end