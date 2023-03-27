require 'test_helper'

class PayGradeMethodTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
    end

    should "have a make_active method" do
      deny @c0.active
      @c0.make_active
      @c0.reload
      assert @c0.active
    end

    should "have a make_inactive method" do
      assert @c1.active
      @c1.make_inactive
      @c1.reload
      deny @c1.active
    end

  end
end