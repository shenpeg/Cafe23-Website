module ApplicationHelper
  def get_relevant_assignments
    if current_user.manager_role?
      this_store = current_user.current_assignment.store
      @relevant_assignments = Assignment.current.for_store(this_store).by_employee
    else
      @relevant_assignments = Assignment.current.by_employee
    end
    @relevant_assignments.map{|a| ["#{a.employee.name}", a.id] }
  end

  def get_active_pay_grades
    PayGrade.active.alphabetical.map{|pg| ["#{pg.level}", pg.id] }
  end
end
