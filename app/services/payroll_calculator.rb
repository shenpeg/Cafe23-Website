class PayrollCalculator
  # Any payroll calculation is always for a date range, whether
  # it's past two weeks or just start and ending on today. 
  # Therefore, always initialize a calculator object with an 
  # appropriate date range object.
  def initialize(date_range)
    @date_range = date_range
    @start_date = date_range.start_date
    @end_date = date_range.end_date
    @payrolls = Hash.new
  end

  attr_reader :date_range, :start_date, :end_date
  attr_accessor :payrolls

  def create_payrolls_for(store)
    reset_payrolls_hash
    all_shifts = Shift.for_store(store).for_dates(date_range).by_employee
    all_shifts.each do |shift|
      add_to_payrolls(shift)
    end
    # return an array of payroll objects, one for each employee
    # working shifts at the store during that date range
    return payrolls.values
  end

  def create_payroll_record_for(employee)
    reset_payrolls_hash
    all_shifts = Shift.for_employee(employee).for_dates(date_range)
    if all_shifts.empty?
      return create_null_payroll(employee)
    end
    all_shifts.each do |shift|
      add_to_payrolls(shift)
    end
    # return a payroll object for the employee in question,
    # for all shifts worked during that date range
    return payrolls.values.first
  end

  private
  def add_to_payrolls(shift)
    employee = shift.employee
    payroll = get_or_set_employee_payroll_object(employee, shift)
    revised_payroll = increment_pay_earned(payroll, shift)
    payrolls[employee] = revised_payroll
  end

  def get_or_set_employee_payroll_object(employee, shift)
    if !payrolls.keys.include?(employee)
      payroll = Payroll.new(employee)
    else
      payroll = payrolls[employee]
    end
    payroll.pay_grade = employee.pay_grade_on(shift.date)
    payroll.pay_rate = employee.pay_rate_on(shift.date)
    return payroll
  end

  def increment_pay_earned(payroll, shift)
    payroll.hours += shift.duration
    payroll.pay_earned += (shift.duration) * (payroll.pay_rate)
    return payroll
  end

  def create_null_payroll(employee)
    payroll = Payroll.new(employee)
    payroll.pay_grade = employee.current_pay_grade
    payroll.pay_rate = employee.current_pay_rate
    return payroll
  end

  def reset_payrolls_hash
    @payrolls = Hash.new
  end

end