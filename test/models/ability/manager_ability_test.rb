require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of manager users" do
      create_manager_abilities
      # no global privileges
      deny @kathryn_ability.can? :manage, :all
      # testing particular abilities
      deny @kathryn_ability.can? :manage, PayGrade
      deny @kathryn_ability.can? :manage, PayGradeRate
      deny @kathryn_ability.can? :manage, Job
      assert @kathryn_ability.can? :manage, Shift
      assert @kathryn_ability.can? :manage, ShiftJob

      assert @kathryn_ability.can? :index, Store
      assert @kathryn_ability.can? :show, @oakland
      deny @kathryn_ability.can? :show, @cmu
      deny @kathryn_ability.can? :create, Store
      deny @kathryn_ability.can? :update, Store

      assert @kathryn_ability.can? :index, Assignment
      assert @kathryn_ability.can? :show, @assign_ralph
      deny @kathryn_ability.can? :show, @assign_cindy
      deny @kathryn_ability.can? :create, Assignment
      deny @kathryn_ability.can? :update, Assignment

      assert @kathryn_ability.can? :index, Employee
      assert @kathryn_ability.can? :show, @kathryn
      assert @kathryn_ability.can? :show, @ralph
      deny @kathryn_ability.can? :show, @cindy
      deny @kathryn_ability.can? :create, Employee
      assert @kathryn_ability.can? :edit, @kathryn
      assert @kathryn_ability.can? :edit, @ralph
      deny @kathryn_ability.can? :edit, @cindy
      assert @kathryn_ability.can? :update, @kathryn
      assert @kathryn_ability.can? :update, @ralph
      deny @kathryn_ability.can? :update, @cindy
    end
  end
end