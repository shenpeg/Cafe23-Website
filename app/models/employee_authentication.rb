module EmployeeAuthentication 

  # For view dropdowns
  ROLES_LIST = [['Employee', 0],['Manager', 1],['Administrator', 2]].freeze
  
  # login by username
  def Employee.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end 

end 