class AssignmentsController <  ApplicationController
  before_action :check_login
  authorize_resource
    

end
