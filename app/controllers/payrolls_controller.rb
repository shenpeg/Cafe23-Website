class PayrollsController <  ApplicationController
  before_action :check_login

  def store_form
    authorize! :store_form, :payrolls_controller
    
    if current_user.manager_role?
      @stores = [current_user.current_assignment.store]
    end
    if current_user.admin_role?
      @stores = Store.all
    end
  end

  def employee_form
    authorize! :employee_form, :payrolls_controller

    if current_user.manager_role?
      @employees = current_user.current_assignment.store.employees.all
    else
      @employees = Employee.all
    end
  end

  def employee_payroll
    authorize! :employee_payroll, :payrolls_controller

    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @calculator = PayrollCalculator.new(DateRange.new(@start_date, @end_date))

    @employee_payroll = @calculator.create_payroll_record_for(Employee.find(params[:employee_id]))
  end

  def store_payroll
    authorize! :store_payroll, :payrolls_controller

    if current_user.manager_role?
      store = current_user.current_assignment.store
    end
    if current_user.admin_role?
      store = Store.find(params[:store_id])
    end

    @start_date = Date.parse(params[:start_date])
    @end_date = Date.parse(params[:end_date])
    @calculator = PayrollCalculator.new(DateRange.new(@start_date, @end_date))

    @store_payroll = @calculator.create_payrolls_for(store)
  end

end
