require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:store)
  should belong_to(:employee)
  should belong_to(:pay_grade)
  should have_many(:shifts)

  should validate_presence_of(:store_id)
  should validate_presence_of(:employee_id)
  should validate_presence_of(:pay_grade_id)
  should allow_value(7.weeks.ago.to_date).for(:start_date)
  should allow_value(2.years.ago.to_date).for(:start_date)
  should_not allow_value(1.week.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(nil).for(:start_date)

end
