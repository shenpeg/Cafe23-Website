require 'test_helper'

class ShiftScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_assignments
      create_shifts
    end

    # test scopes...
    should "have a scope for completed shifts" do
      create_jobs
      create_shift_jobs
      assert_equal [@shift_ralph_1, @shift_ralph_2], Shift.completed.sort_by{|s| s.date}
      destroy_shift_jobs
      destroy_jobs
    end
    
    should "have a scope for incomplete shifts" do
      create_jobs
      create_shift_jobs
      assert_equal [@shift_ralph_3, @shift_ralph_4, @shift_kathryn, @shift_cindy], Shift.incomplete.sort_by{|s| s.date}
      destroy_shift_jobs
      destroy_jobs
    end
    
    should "have a scope called for_store" do
      assert_equal [@shift_cindy], Shift.for_store(@cmu).sort_by{|s| s.date}
      assert_equal 5, Shift.for_store(@oakland).size
    end
    
    should "have a scope called for_employee" do
      assert_equal [@shift_ralph_1, @shift_ralph_2, @shift_ralph_3, @shift_ralph_4], Shift.for_employee(@ralph).sort_by{|s| s.date}
      assert_equal [@shift_cindy], Shift.for_employee(@cindy)
    end
    
    should "have a scope for past shifts" do
      assert_equal [@shift_ralph_1, @shift_ralph_2, @shift_ralph_3], Shift.past.sort_by{|s| s.date}
    end
    
    should "have a scope for upcoming shifts" do
      assert_equal [@shift_ralph_4, @shift_kathryn, @shift_cindy], Shift.upcoming.sort_by{|s| s.date}
    end

    should "have a scope called for_next_days" do
      assert_equal [@shift_ralph_4, @shift_kathryn], Shift.for_next_days(0)
      assert_equal [@shift_ralph_4, @shift_kathryn, @shift_cindy], Shift.for_next_days(2).sort_by{|s| s.date}
    end
    
    should "have a scope called for_past_days" do
      assert_equal [@shift_ralph_3], Shift.for_past_days(1)
      assert_equal [@shift_ralph_2,@shift_ralph_3], Shift.for_past_days(2).sort_by{|s| s.date}
      assert_equal 3, Shift.for_past_days(3).size
    end

    # scope not in phase 3 requirements (b/c uses date range object)
    should "have a scope called for_dates" do
      date_range = DateRange.new(5.days.ago.to_date, 2.days.ago.to_date)
      assert_equal [@shift_ralph_1,@shift_ralph_2], Shift.for_dates(date_range).sort_by{|s| s.date}
    end
    
    should "have a scope to order chronologically" do
      assert_equal ['Ralph','Ralph','Ralph','Kathryn','Ralph','Cindy'], Shift.chronological.map{|s| s.employee.first_name}
    end

    should "have a scope to order by store name" do
      assert_equal ['CMU','Oakland','Oakland','Oakland','Oakland','Oakland'], Shift.by_store.map{|s| s.store.name}
    end
    
    should "have a scope to order by employee name" do
      assert_equal ['Crawford, Cindy','Janeway, Kathryn','Wilson, Ralph','Wilson, Ralph','Wilson, Ralph','Wilson, Ralph'], Shift.by_employee.map{|s| s.employee.name}
    end

    # test enum scopes
    should "have a scope for pending shifts" do
      assert_equal [@shift_ralph_4, @shift_cindy], Shift.pending.sort_by{|s| s.date}
    end

    should "have a scope for started shifts" do
      assert_equal [ @shift_kathryn], Shift.started.sort_by{|s| s.date}
    end

    should "have a scope for finished shifts" do
      assert_equal [@shift_ralph_1, @shift_ralph_2, @shift_ralph_3], Shift.finished.sort_by{|s| s.date}
    end


  end
end
