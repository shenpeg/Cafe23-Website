class PayGradesController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @pay_grades = PayGrade.all
  end

  def show
    @pay_grade = PayGrade.find(params[:id])
    @pay_grade_rate_history = @pay_grade.pay_grade_rates.order('effective_date DESC')
  end

  def new
    @pay_grade = PayGrade.new
  end

  def edit
    @pay_grade = PayGrade.find(params[:id])
  end

  def create
    @pay_grade = PayGrade.new(pay_grade_params)
    if @pay_grade.save
      redirect_to pay_grades_path, notice: 'Pay grade was successfully created.'
    else
      render :new
    end
  end

  def update
    @pay_grade = PayGrade.find(params[:id])
    if @pay_grade.update(pay_grade_params)
      redirect_to pay_grades_path, notice: 'Pay grade was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # There should be no destroy action for pay grades
  end

  private
    def pay_grade_params
      params.require(:pay_grade).permit(:level, :active)
    end
end
