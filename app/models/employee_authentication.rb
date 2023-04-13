module EmployeeAuthentication 

  # For view dropdowns
  ROLES_LIST = [['Employee', 'employee'],['Manager', 'manager'],['Administrator', 'admin']].freeze
  
  # login by username
  def Employee.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end 

end 