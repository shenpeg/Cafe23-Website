require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:assignment)
  should have_one(:employee).through(:assignment)
  should have_one(:store).through(:assignment)
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)

  should validate_presence_of(:assignment_id)

  should allow_value("pending").for(:status)
  should allow_value("started").for(:status)
  should allow_value("finished").for(:status)
  should_not allow_value("").for(:status)
  should_not allow_value(nil).for(:status)

end
