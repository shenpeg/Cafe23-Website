require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of employee users" do
      create_employee_abilities
      # no global privileges
      deny @ralph_ability.can? :manage, :all
      # testing particular abilities
      deny @ralph_ability.can? :manage, PayGrade
      deny @ralph_ability.can? :manage, PayGradeRate
      deny @ralph_ability.can? :manage, Job
      deny @ralph_ability.can? :manage, Store
      deny @ralph_ability.can? :manage, ShiftJob

      assert @ralph_ability.can? :index, Assignment
      assert @ralph_ability.can? :show, @assign_ralph
      deny @ralph_ability.can? :show, @assign_cindy
      deny @ralph_ability.can? :create, Assignment
      deny @ralph_ability.can? :update, Assignment

      deny @ralph_ability.can? :index, Employee
      deny @ralph_ability.can? :show, @kathryn
      assert @ralph_ability.can? :show, @ralph
      deny @ralph_ability.can? :show, @cindy
      deny @ralph_ability.can? :create, Employee
      deny @ralph_ability.can? :edit, @kathryn
      assert @ralph_ability.can? :edit, @ralph
      deny @ralph_ability.can? :update, @kathryn
      assert @ralph_ability.can? :update, @ralph

      assert @ralph_ability.can? :time_clock, Shift
      assert @ralph_ability.can? :time_in, Shift
      assert @ralph_ability.can? :time_out, Shift
    end
  end
end