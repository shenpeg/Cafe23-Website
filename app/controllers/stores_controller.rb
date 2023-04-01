class StoresController < ApplicationController
  before_action :check_login
  authorize_resource
    

end
