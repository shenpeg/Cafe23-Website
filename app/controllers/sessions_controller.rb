class SessionsController < ApplicationController
  def new
  end
  
  def create
    employee = Employee.authenticate(params[:username], params[:password])
    if employee
      session[:employee_id] = employee.id
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Username and/or password is invalid"
      render "new"
    end
  end
  
  def destroy
    session[:employee_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end

    

end
