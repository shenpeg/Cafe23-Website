class PayRollController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
  end

  def show
  end

  def new
    @pay_grade = PayGrade.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
