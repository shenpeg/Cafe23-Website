require 'test_helper'

class PayGradeTest < ActiveSupport::TestCase
  # Matchers
  should have_many(:assignments)
  should have_many(:pay_grade_rates)
  should validate_presence_of(:level)
  should validate_uniqueness_of(:level).case_insensitive

end