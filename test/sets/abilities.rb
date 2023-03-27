module Contexts
  module Abilities
    # Admins
    def create_admin_abilities
      @alex = FactoryBot.create(:employee, first_name: "Alex", username: "alex", last_name: "Heimann", role: "admin")
      @alex_ability = Ability.new(@alex)
    end

    def create_manager_abilities
      # created related objects for testing
      create_employees
      create_stores
      create_pay_grades
      create_assignments
      # make the manager ability using Kathryn (Oakland store)
      @kathryn_ability = Ability.new(@kathryn)
    end

    def create_employee_abilities
      # created related objects for testing
      create_employees
      create_stores
      create_pay_grades
      create_assignments
      # make the employee ability using Ralph (also Oakland store)
      @ralph_ability = Ability.new(@ralph)
    end

  end
end