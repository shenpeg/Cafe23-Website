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

  def time_in
    @shift = current_user.shifts.find_by(date: Date.current)

    if @shift.present?
      TimeClock.new(@shift).start_shift_at(Time.now)
      flash[:notice] = "Your shift has started."
    else
      flash[:notice] = "You do not have any shifts today"
    end
  
    redirect_to home_path, notice: flash[:notice]
  end

  def time_out
    @shift = current_user.shifts.find_by(date: Date.current)

    if @shift.present?
      TimeClock.new(@shift).end_shift_at(Time.now)
      @shift.update(status: 3)
      flash[:notice] = "Your shift has ended."
    else
      flash[:notice] = "You do not have any shifts today"
    end
  
    redirect_to home_path, notice: flash[:notice]
  end

  def time_clock
    @shift_today = current_user.shifts.find_by(date: Date.current)

    if @shift_today.present?
      if @shift_today.started?
        # @clock_message = "Please clock in"
      end
    else
      flash[:notice] = "You do not have any shifts today"
      redirect_to home_path
    end
  end

  private
    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end
end
