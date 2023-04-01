class PayGradeRatesController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
  end

  def show
  end

  def new
    @pay_grade_rate = PayGradeRate.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
    def pay_grade_rate_params
      params.require(:pay_grade_rate).permit(:pay_grade_id, :rate, :start_date, :end_date)
    end

end
