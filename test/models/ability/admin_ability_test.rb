require 'test_helper'

class AdminAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of admin users to do everything" do
      create_admin_abilities
      assert @alex_ability.can? :manage, :all
    end
  end
end