module EmployeePayment
  def current_pay_grade
    curr_assignment = self.assignments.current    
    return nil if curr_assignment.empty?
    curr_assignment.first.pay_grade.level   # return string representing the level
  end

  def current_pay_rate
    curr_assignment = self.assignments.current    
    return nil if curr_assignment.empty?
    curr_assignment.first.pay_grade.pay_grade_rates.current.first.rate 
  end
  
  def pay_grade_on(date)
    assignment_on_date = self.assignments.for_date(date)    
    return nil if assignment_on_date.empty?
    assignment_on_date.first.pay_grade.level   # return string representing the level
  end

  def pay_rate_on(date)
    assignment_on_date = self.assignments.for_date(date)    
    return nil if assignment_on_date.empty?
    pay_grade_on_date = assignment_on_date.first.pay_grade
    pay_rate_on_date = PayGradeRate.for_date(date).for_pay_grade(pay_grade_on_date).first.rate 
  end
end