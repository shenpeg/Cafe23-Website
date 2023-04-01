class JobsController <  ApplicationController
  before_action :check_login
  authorize_resource

  def index
  end

  def show
  end

  def new
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
    def job_params
      params.require(:job).permit(:name, :description, :active)
    end
end