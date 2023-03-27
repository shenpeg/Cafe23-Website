# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(employee)
    # set user to new Employee user if not logged in
    employee ||= Employee.new # i.e., a guest user
  
    # set authorizations for different user roles
    ## ADMIN
    if employee.admin_role? 
      # they get to do it all
      can :manage, :all
    end

    ## MANAGER
    if employee.manager_role?
      can :manage, Shift
      can :manage, ShiftJob
      can :index, Store
      # can see store details if they are assigned to manage that store
      can :show, Store do |store|  
        store.id == employee.current_assignment.store.id
      end
      can :index, Assignment
      # can see assignment details if assignment currently linked to manager's store
      can :show, Assignment do |assgn| 
        current_assignees = Assignment.current.for_store(employee.current_assignment.store).to_a
        current_assignees.include?(assgn)
      end
      can :index, Employee
      # can see and update employee details if employee currently linked to manager's store
      can [:show, :edit, :update], Employee do |emp| 
        current_employees = Assignment.current.for_store(employee.current_assignment.store).map{|a| a.employee}
        current_employees.include?(emp)
      end
      # can handle store payrolls
      can [:store_form, :store_report], :payrolls_controller
    end

    ## EMPLOYEE
    if employee.employee_role?
      can [:index, :show], Assignment do |assgn| 
        my_assignment = employee.assignments.to_a
        my_assignment.include?(assgn)
      end
      # can see and update employee details themselves
      can [:show, :edit, :update], Employee, id: employee.id

      # can access the time clock
      can [:time_clock, :time_in, :time_out], Shift
    end

  end
end
