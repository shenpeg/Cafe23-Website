require 'test_helper'

class PayGradeScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
    end

    should "have all active pay grades accounted for" do
      assert_equal 5, PayGrade.active.size 
      deny PayGrade.active.include?(@c0)
      assert_equal [@c1,@c2,@c3,@m1,@m2], PayGrade.active.sort_by{|pg| pg.level}
    end

    should "have all inactive pay grades accounted for" do
      assert_equal 1, PayGrade.inactive.size 
      deny PayGrade.inactive.include?(@m1)
      assert_equal [@c0], PayGrade.inactive
    end

    should "list pay grades alphabetically" do
      assert_equal [@c0, @c1, @c2, @c3, @m1, @m2], PayGrade.alphabetical
    end

  end
end