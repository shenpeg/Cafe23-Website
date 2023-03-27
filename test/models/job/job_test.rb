require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # Matchers
  should have_many(:shift_jobs)
  should have_many(:shifts).through(:shift_jobs)

  should validate_presence_of(:name)

end
