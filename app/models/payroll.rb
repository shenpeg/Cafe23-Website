class Payroll
  def initialize(employee)
    @employee = employee
    @employee_name = employee.name
    @ssn = employee.ssn
    @pay_grade = nil
    @pay_rate = nil
    @hours = 0.0
    @pay_earned = 0.0
  end

  attr_reader :employee, :employee_name, :ssn
  attr_accessor :pay_grade, :pay_rate, :hours, :pay_earned

end