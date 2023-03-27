require 'test_helper'

class PayGradeRateDeletionTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
      create_pay_grade_rates
    end
  
    should "not allow pay grade rates to be destroyed for any reason" do
      deny @m1_t0.destroy
    end

  end
end
