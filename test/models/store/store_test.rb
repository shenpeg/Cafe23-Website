require 'test_helper'

class StoreTest < ActiveSupport::TestCase

  # Matchers
  should have_many(:assignments)
  should have_many(:employees).through(:assignments)
  should have_many(:shifts).through(:assignments) 

  # Test basic validations
  should validate_presence_of(:name)
  should validate_presence_of(:street)
  should validate_presence_of(:city)
  should validate_uniqueness_of(:name).case_insensitive()

  # tests for zip
  should allow_value("15213").for(:zip)
  should_not allow_value("bad").for(:zip)
  should_not allow_value("1512").for(:zip)
  should_not allow_value("152134").for(:zip)
  should_not allow_value("15213-0983").for(:zip)
  # tests for state
  should allow_value("OH").for(:state)
  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  should_not allow_value(nil).for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value("NY").for(:state)
  should_not allow_value(10).for(:state)
  should_not allow_value("CA").for(:state)
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

  # Context
  context "Given context" do
    setup do 
      create_stores
    end
    
    teardown do
      # destroy_stores
    end

    # test the scope 'active'
    should "have all active stores accounted for" do
      assert_equal 2, Store.active.size 
      deny Store.active.include?(@hazelwood)
      assert_equal [@cmu,@oakland], Store.active.sort_by{|store| store.name}
    end

    # test the scope 'inactive'
    should "have all inactive stores accounted for" do
      assert_equal 1, Store.inactive.size 
      deny Store.inactive.include?(@cmu)
      assert_equal [@hazelwood], Store.inactive
    end

    # test 'make_active' method
    should "have a make_active method" do
      deny @hazelwood.active
      @hazelwood.make_active
      @hazelwood.reload
      assert @hazelwood.active
    end

    # test 'make_inactive' method
    should "have a make_inactive method" do
      assert @cmu.active
      @cmu.make_inactive
      @cmu.reload
      deny @cmu.active
    end

    # test scope alphabetical
    should "list stores alphabetically" do
      assert_equal [@cmu, @hazelwood, @oakland], Store.alphabetical
    end

    # test the callback is working 'reformat_phone'
    should "shows that Oakland's phone is stripped of non-digits" do
      assert_equal "4122688211", @oakland.phone
    end

    # test that stores cannot be destroyed
    should "not allow stores to be destroyed for any reason" do
      deny @oakland.destroy
    end

  end
end
