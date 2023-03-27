require 'test_helper'

class EmployeeScopeTest < ActiveSupport::TestCase

  context "Given context" do
    setup do 
      create_employees
    end

    # test the scope 'active'
    should "have all active employees accounted for" do
      assert_equal 6, Employee.active.size 
      deny Employee.active.include?(@chuck)
      assert_equal [@alex,@ben,@cindy,@ed,@kathryn,@ralph], Employee.active.sort_by{|emp| emp.first_name}
    end

    # test the scope 'inactive'
    should "have all inactive employees accounted for" do
      assert_equal 1, Employee.inactive.size 
      deny Employee.inactive.include?(@ralph)
      assert_equal [@chuck], Employee.inactive
    end

    # test scope alphabetical
     should "list employees alphabetically" do
      assert_equal ["Crawford", "Gruberman", "Heimann", "Janeway", "Sisko", "Waldo", "Wilson"], Employee.alphabetical.map{|e| e.last_name}
    end   

    # test scope younger_than_18
    should "show there are two employees under 18" do
      assert_equal 2, Employee.younger_than_18.size
      assert_equal ["Crawford", "Wilson"], Employee.younger_than_18.map{|e| e.last_name}.sort
    end
    
    # test scope is_18_or_older
    should "show there are four employees over 18" do
      assert_equal 5, Employee.is_18_or_older.size
      assert_equal ["Gruberman", "Heimann", "Janeway", "Sisko", "Waldo"], Employee.is_18_or_older.alphabetical.map{|e| e.last_name}.sort
    end

    # test the scope 'regulars'
    should "shows that there are 4 regular employees: Ed, Cindy, Chuck and Ralph" do
      assert_equal 4, Employee.regulars.size
      assert_equal ["Crawford","Gruberman","Waldo","Wilson"], Employee.regulars.map{|e| e.last_name}.sort
    end
    
    # test the scope 'managers'
    should "shows that there are 2 managers: Ben and Kathryn" do
      assert_equal 2, Employee.managers.size
      assert_equal ["Janeway", "Sisko"], Employee.managers.map{|e| e.last_name}.sort
    end
    
    # test the scope 'admins'
    should "shows that there is one admin: Alex" do
      assert_equal 1, Employee.admins.size
      assert_equal [@alex], Employee.admins
    end
   
  end
end
