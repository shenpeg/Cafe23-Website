module EmployeeAuthentication 

  # For view dropdowns
  ROLES_LIST = [['Employee', 1],['Manager', 2],['Administrator', 3]].freeze
  
  # login by username
  def Employee.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end 

end 