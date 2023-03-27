require 'test_helper'

class PayGradeDeletionTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_pay_grades
    end

    should "not allow pay grades to be destroyed for any reason" do
      deny @c1.destroy
    end

  end
end