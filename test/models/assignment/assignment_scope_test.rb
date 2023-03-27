require 'test_helper'

class AssignmentScopeTest < ActiveSupport::TestCase
  # Context
  context "Given context" do
    setup do 
      create_stores
      create_employees
      create_pay_grades
      create_pay_grade_rates
      create_assignments
    end

    should "have a scope 'for_store' that works" do
      assert_equal 4, Assignment.for_store(@cmu).size
      assert_equal 2, Assignment.for_store(@oakland).size
      assert_equal [@assign_ralph, @assign_kathryn], Assignment.for_store(@oakland).to_a
    end
    
    should "have a scope 'for_employee' that works" do
      assert_equal 2, Assignment.for_employee(@ben).size
      assert_equal 1, Assignment.for_employee(@kathryn).size
      assert_equal [@assign_ben, @promote_ben], Assignment.for_employee(@ben).to_a
    end
    
    should "have a scope 'for_role' that works" do
      assert_equal 3, Assignment.for_role(:employee).size
      assert_equal 3, Assignment.for_role(:manager).size
      assert_equal [@assign_ben, @promote_ben, @assign_kathryn], Assignment.for_role(:manager).to_a
    end

    should "have a scope 'for_pay_grade' that works" do
      assert_equal 3, Assignment.for_pay_grade(@c1).size
      assert_equal 0, Assignment.for_pay_grade(@c2).size
      assert_equal 2, Assignment.for_pay_grade(@m1).size
      assert_equal 1, Assignment.for_pay_grade(@m2).size
      assert_equal [@assign_ben, @assign_kathryn], Assignment.for_pay_grade(@m1).to_a
    end
    
    should "have all the assignments listed alphabetically by store name" do
      assert_equal ["CMU", "CMU", "CMU", "CMU", "Oakland", "Oakland"], Assignment.by_store.map{|a| a.store.name}
    end
    
    should "have all the assignments listed chronologically by start date" do
      assert_equal ["Ben", "Ralph", "Kathryn", "Ed", "Cindy", "Ben"], Assignment.chronological.map{|a| a.employee.first_name}
    end
    
    should "have all the assignments listed alphabetically by employee name" do
      assert_equal ["Crawford", "Gruberman", "Janeway", "Sisko", "Sisko", "Wilson"], Assignment.by_employee.map{|a| a.employee.last_name}
    end

    should "have a scope to find all assignments for a given date" do
      assert_equal 3, Assignment.for_date(11.months.ago.to_date).size
      assert_equal [@assign_ben, @assign_cindy, @assign_ed], Assignment.for_date(11.months.ago.to_date).sort_by{|a| a.employee.first_name}
    end

    should "have a scope to find all current assignments for a store or employee" do
      assert_equal 2, Assignment.current.for_store(@cmu).size
      assert_equal 2, Assignment.current.for_store(@oakland).size
      assert_equal [@assign_ralph, @assign_kathryn], Assignment.current.for_store(@oakland).to_a
      assert_equal 1, Assignment.current.for_employee(@ben).size
      assert_equal [@promote_ben], Assignment.current.for_employee(@ben).to_a
      assert_equal 0, Assignment.current.for_employee(@ed).size
    end
    
    should "have a scope to find all past assignments for a store or employee" do
      assert_equal 2, Assignment.past.for_store(@cmu).size
      assert_equal [@assign_ed, @assign_ben], Assignment.past.for_store(@cmu).to_a
      assert_equal 0, Assignment.past.for_store(@oakland).size
      assert_equal 1, Assignment.past.for_employee(@ben).size
      assert_equal [@assign_ben], Assignment.past.for_employee(@ben).to_a
      assert_equal 0, Assignment.past.for_employee(@cindy).size
    end


  end
end
