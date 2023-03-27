require 'test_helper'

class JobScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_jobs
    end
    
    should "have all active jobs accounted for" do
      assert_equal 3, Job.active.size 
      assert_equal [@baking,@barista,@cashier], Job.active.sort_by{|job| job.name}
    end

    should "have all inactive jobs accounted for" do
      assert_equal 1, Job.inactive.size 
      assert_equal [@mover], Job.inactive
    end

    should "list jobs alphabetically" do
      assert_equal [@baking, @barista, @cashier, @mover], Job.alphabetical
    end

  end
end
