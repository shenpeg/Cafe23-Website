require 'test_helper'

class JobMethodTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_jobs
    end
  
    should "have a make_active method" do
      deny @mover.active
      @mover.make_active
      @mover.reload
      assert @mover.active
    end

    should "have a make_inactive method" do
      assert @cashier.active
      @cashier.make_inactive
      @cashier.reload
      deny @cashier.active
    end

  end
end
