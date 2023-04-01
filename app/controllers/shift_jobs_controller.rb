class ShiftJobsController < ApplicationController
  before_action :check_login
  authorize_resource

  def index
  end

  def show
  end

  def new
    @shift_job = ShiftJob.new
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
    def shift_job_params
      params.require(:shift_job).permit(:shift_id, :job_id)
    end
end
