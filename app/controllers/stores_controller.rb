class StoresController < ApplicationController
  before_action :check_login
  authorize_resource
    
  def index
    @active_stores = Store.active.alphabetical.paginate(page: params[:page]).per_page(15)
    @inactive_stores = Store.inactive.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
    @store = Store.find(params[:id])
    @current_employees = @store.current_employees.alphabetical.to_a  
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(store_params)

    if @store.save
      redirect_to store_path(@store), notice: "Store was successfully created."
    else
      render :new
    end
  end

  def update
    @store = Store.find(params[:id])

    if @store.update(store_params)
      redirect_to store_path(@store), notice: "Updated store information for " + @store.name + "."
    else
      render :edit
    end
  end

  def destroy
    ## We don't allow destroy (will deactivate instead)
    @store.make_inactive
    #redirect_to stores_url, notice: "Successfully deactivated #{@store.name} along with associated stuff."
  end

  private
    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :email, :active)
    end

    # def user_params      
    #   params.require(:admin).permit(:first_name, :last_name, :active, :username, :password, :password_confirmation)
    # end
end
