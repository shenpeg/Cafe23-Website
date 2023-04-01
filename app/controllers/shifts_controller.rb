class ShiftsController < ApplicationController
  before_action :check_login
  authorize_resource

  def index
  end

  def show
  end

  def new
    @shift = Shift.new
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
    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end
end
