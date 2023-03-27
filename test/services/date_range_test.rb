require 'test_helper'

class DateRangeTest < ActiveSupport::TestCase

  context "Create context for date range" do

    should "show that setter methods don't work but getters do" do
      normal = DateRange.new(2.years.ago.to_date, 1.year.ago.to_date)
      assert normal.respond_to?(:start_date)
      assert normal.respond_to? :end_date
      assert !normal.respond_to?(:start_date=)
      assert !normal.respond_to?(:end_date=)
    end

    should "show that date range created with normal start and end dates" do
      normal = DateRange.new(2.years.ago.to_date, 1.year.ago.to_date)
      assert_equal normal.start_date, 2.years.ago.to_date
      assert_equal normal.end_date, 1.year.ago.to_date
    end

    should "show that when dates are reversed, it's corrected in init()" do
      reversed = DateRange.new(1.year.ago.to_date, 2.years.ago.to_date)
      assert_equal reversed.start_date, 2.years.ago.to_date
      assert_equal reversed.end_date, 1.year.ago.to_date
    end

    should "show that if only one date given and in the future, start date set to current" do
      future = DateRange.new(2.years.from_now.to_date)
      assert_equal future.start_date, Date.current
      assert_equal future.end_date, 2.years.from_now.to_date
    end

    should "show that if only one date given and in the past, end date set to current" do
      past = DateRange.new(2.years.ago.to_date)
      assert_equal past.start_date, 2.years.ago.to_date
      assert_equal past.end_date, Date.current
    end

    should "show that if only one date given and in the present, range starts/ends today" do
      present = DateRange.new(Date.current)
      assert_equal present.start_date, Date.current
      assert_equal present.end_date, Date.current
    end

    should "show that date is or isn't included in date range" do
      normal = DateRange.new(2.years.ago.to_date, 1.year.ago.to_date)
      assert normal.include?(16.months.ago.to_date)
      assert normal.include?(12.months.ago.to_date)
      assert normal.include?(24.months.ago.to_date)
      deny normal.include?(25.months.ago.to_date)
      deny normal.include?(11.months.ago.to_date)
    end

    should "know how many days in the date range" do
      normal = DateRange.new(2.weeks.ago.to_date, 1.week.ago.to_date)
      assert_equal 7, normal.number_of_days
    end
    
    should "raise an exception if no arguments are passed or if not a valid date" do
      assert_raise Exceptions::NoDatesGiven do DateRange.new(); end
      assert_raise Exceptions::NoDatesGiven do DateRange.new("bad"); end
      assert_raise Exceptions::NoDatesGiven do DateRange.new(3.14159); end
      assert_raise Exceptions::NoDatesGiven do DateRange.new(1.year.ago.to_date, "bad"); end
    end

    should "raise an exception if too many arguments are passed" do
      assert_raise Exceptions::TooManyArguments do DateRange.new(1.year.ago.to_date, 1.month.ago.to_date, 1.week.ago.to_date); end
    end
 
  end
end