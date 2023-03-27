require 'test_helper'

class PayGradeRateScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
      create_pay_grade_rates
    end
  
    should "order pay grade rates chronologically" do
      assert_equal [@m1_t0,@c1_t0,@c2_t0,@c3_t0,@m2_t0,@m1_t1,@c1_t1,@c2_t1,@c1_t2], PayGradeRate.chronological
    end

    should "return current pay grade rates for each pay grade" do
      assert_equal [@c3_t0,@m2_t0,@m1_t1,@c2_t1,@c1_t2], PayGradeRate.current.sort_by{|pgr| pgr.start_date}
    end

    should "select pay grade rates for a given pay grade" do
      assert_equal [@m1_t0,@m1_t1], PayGradeRate.for_pay_grade(@m1).sort_by{|pgr| pgr.start_date}
    end

    should "have a scope to find all pay grade rates for a given date" do
      assert_equal 5, PayGradeRate.for_date(19.months.ago.to_date).size
      assert_equal [@c1_t0,@c2_t0,@c3_t0,@m1_t0,@m2_t0], PayGradeRate.for_date(19.months.ago.to_date).sort_by{|r| r.rate}
    end

  end
end
