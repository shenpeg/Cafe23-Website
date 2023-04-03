class ShiftsController < ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @shifts = Shift.all
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to @shift, notice: 'Shift was successfully created.'
    else
      render :new
    end
  end

  def update
    @shift = Shift.find(params[:id])
    if @shift.update(shift_params)
      redirect_to @shift, notice: 'Shift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shift = Shift.find(params[:id])
    if @shift.destroy
      redirect_to shifts_url, notice: 'Shift was successfully destroyed.'
    else
      flash[:notice] = 'Shift could not be destroyed.'
      render :show
    end
  end

  # POST /time_in
  def time_in
    shift = current_user.current_shift

    if shift.nil?
      redirect_to home_path, notice: 'You do not have any shifts today.'
    else
      shift.clock_in!
      redirect_to home_path, notice: 'Your shift has started.'
    end
  end

  # POST /time_out
  def time_out
    shift = current_user.current_shift

    if shift.nil?
      redirect_to home_path, notice: 'You do not have any shifts today.'
    else
      shift.clock_out!
      redirect_to home_path, notice: 'Your shift has ended.'
    end
  end

  private
    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end
end
