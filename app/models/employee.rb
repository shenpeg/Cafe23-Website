class Employee < ApplicationRecord
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods
  
  has_secure_password

  # Relationships
  has_many :assignments 
  has_many :stores, through: :assignments
  has_many :shifts, through: :assignments 
  has_many :pay_grades, through: :assignments
  has_many :pay_grade_rates, through: :pay_grades

  # Enums
  enum :role, { employee: 1, manager: 2, admin: 3 }, scopes: false, default: :employee, suffix: true

  # Scopes
  scope :younger_than_18, -> { where('date_of_birth > ?', 18.years.ago.to_date) }
  scope :is_18_or_older,  -> { where('date_of_birth <= ?', 18.years.ago.to_date) }
  scope :regulars,        -> { where('role = ?', roles['employee']) }
  scope :managers,        -> { where('role = ?', roles['manager']) }
  scope :admins,          -> { where('role = ?', roles['admin']) }
  scope :alphabetical,    -> { order('last_name, first_name') }

  # Validations
  validates_presence_of :first_name, :last_name, :ssn
  validates_date :date_of_birth, :on_or_before => lambda { 14.years.ago }, on_or_before_message: 'must be at least 14 years old'
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: 'should be 10 digits (area code needed) and delimited with dashes only'
  validates_format_of :ssn, with: /\A\d{3}[- ]?\d{2}[- ]?\d{4}\z/, message: 'should be 9 digits and delimited with dashes only'
  validates_uniqueness_of :ssn
  # validates_inclusion_of :role, in: roles.keys, message: 'is not an option'
  # ... more validations for later phases
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates_presence_of :role, on: :create
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, on: :create, message: 'does not match'
  validates_length_of :password, minimum: 4, message: 'must be at least 4 characters long', allow_blank: true

  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  def over_18?
    date_of_birth.to_date < 18.years.ago.to_date
  end
  
  def age
    (Time.now.to_formatted_s(:number).to_i - date_of_birth.to_time.to_formatted_s(:number).to_i)/10e9.to_i
  end

  def current_assignment
    curr_assignment = self.assignments.current    
    return nil if curr_assignment.empty?
    curr_assignment.first   # return as a single object, not an array
  end

  # Add in methods for later phases for authentication and payment handling
  include EmployeePayment
  include EmployeeAuthentication

  # Callbacks
  before_save -> { strip_nondigits_from(:phone) }
  before_save -> { strip_nondigits_from(:ssn) }

  # ... additional callbacks in phases 4 & 5
  include EmployeeDeletion
  before_destroy -> { handle_deletion_request() }
  # after_rollback -> { handle_deletion_failure() }

end
