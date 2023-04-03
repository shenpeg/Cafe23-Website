class ShiftJobsController < ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @shift = Shift.find(params[:shift_id])
    @shift_job = ShiftJob.new(shift: @shift)
  end

  def new
    @shift_job = ShiftJob.new
  end

  def create
    @shift_job = ShiftJob.new(shift_job_params)

    if @shift_job.save
      redirect_to shift_path(@shift_job.shift), notice: 'Shift job was successfully created.'
    else
      @shift = @shift_job.shift
      render :new
    end
  end

  def destroy
    @shift_job = ShiftJob.find(params[:id])
    shift = @shift_job.shift
    @shift_job.destroy
    redirect_to shift_path(shift), notice: 'Shift job was successfully destroyed.'
  end

  private
    def shift_job_params
      params.require(:shift_job).permit(:shift_id, :job_id)
    end
end
