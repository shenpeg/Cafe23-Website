require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Matchers
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)
  should have_many(:shifts).through(:assignments)
  should have_many(:pay_grades).through(:assignments)
  should have_many(:pay_grade_rates).through(:pay_grades)
  should have_secure_password

  # Test basic validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:ssn)
  should validate_presence_of(:role)
  should validate_presence_of(:username)
  # tests for phone
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should_not allow_value(nil).for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("14122683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  # tests for ssn
  should allow_value("123456789").for(:ssn)
  should_not allow_value("12345678").for(:ssn)
  should_not allow_value("1234567890").for(:ssn)
  should_not allow_value("bad").for(:ssn)
  should_not allow_value(nil).for(:ssn)
  # test date_of_birth
  should allow_value(17.years.ago.to_date).for(:date_of_birth)
  should allow_value(15.years.ago.to_date).for(:date_of_birth)
  should allow_value(14.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(13.years.ago).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(nil).for(:date_of_birth)
  # tests for role
  should allow_value("admin").for(:role)
  should allow_value("manager").for(:role)
  should allow_value("employee").for(:role)
  should_not allow_value("").for(:role)
  should_not allow_value(nil).for(:role)
  
  # Context
  context "Given context" do
    setup do 
      create_employees
    end
    
    teardown do
      # destroy_employees
    end

    # a manual test employees must have unique ssn (could have used a matcher...)
    should "force employees to have unique ssn" do
      repeat_ssn = FactoryBot.build(:employee, first_name: "Steve", last_name: "Crawford", ssn: "084359822")
      deny repeat_ssn.valid?
    end

    # test 'make_active' method
    should "have a make_active method" do
      deny @chuck.active
      @chuck.make_active
      @chuck.reload
      assert @chuck.active
    end

    # test 'make_inactive' method
    should "have a make_inactive method" do
      assert @ralph.active
      @ralph.make_inactive
      @ralph.reload
      deny @ralph.active
    end

    # test the method 'name'
    should "shows name as last, first name" do
      assert_equal "Heimann, Alex", @alex.name
    end   
    
    # test the method 'proper_name'
    should "shows proper name as first and last name" do
      assert_equal "Alex Heimann", @alex.proper_name
    end 

    # test the callback is working 'reformat_ssn'
    should "shows that Cindy's ssn is stripped of non-digits" do
      assert_equal "084359822", @cindy.ssn
    end
    
    # test the callback is working 'reformat_phone'
    should "shows that Ben's phone is stripped of non-digits" do
      assert_equal "4122682323", @ben.phone
    end

    # test the method 'over_18?'
    should "shows that over_18? boolean method works" do
      assert @ed.over_18?
      deny @cindy.over_18?
    end
    
    # test the method 'age'
    should "shows that age method returns the correct value" do
      assert_equal 19, @ed.age
      assert_equal 17, @cindy.age
      assert_equal 30, @kathryn.age
    end

    # test the method 'current_assignment'
    should "shows return employee's current assignment, if it exists" do
      create_stores
      create_pay_grades
      create_assignments
      # has an assignment
      assert_equal @assign_kathryn, @kathryn.current_assignment
      # has multiple assignments, one is current
      assert_equal @promote_ben, @ben.current_assignment
      # has no assignments, should be nil
      assert_nil @alex.current_assignment
      destroy_assignments
      destroy_pay_grades
      destroy_stores
    end

  end
end
