require 'test_helper'

class PayGradeRateTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:pay_grade)
  should validate_numericality_of(:rate).is_greater_than(0)

end
