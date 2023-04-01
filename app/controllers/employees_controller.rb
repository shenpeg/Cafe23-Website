class EmployeesController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @active_employees = Employee.active.all.paginate(page: params[:page]).per_page(15)
    @inactive_employees = Employee.inactive.all.paginate(page: params[:page]).per_page(15)
  end

  def show
    @employee = Employee.find(params[:id])
    @current_assignment = @employee.current_assignment
    @other_assignments = @employee.assignments - [@current_assignment]
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = "Successfully added #{@employee.proper_name} as an employee."
      redirect_to @employee
    else
      render :new
    end
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      flash[:notice] = "Updated #{@employee.proper_name}'s information."
      redirect_to @employee
    else
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroyable
      @employee.destroy
      flash[:notice] = "Employee deleted."
      redirect_to employees_url
    else
      flash[:notice] = "Employee cannot be deleted because they have an upcoming shift or have worked at the store within the last 30 days."
      render :show
    end
  end

  private
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :username, :password, :password_confirmation, :active)
    end
end
