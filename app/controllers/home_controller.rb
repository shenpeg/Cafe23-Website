class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    #@employees = Employee.search(@query)
    #@total_hits = @owners.size + @pets.size
  end
end
