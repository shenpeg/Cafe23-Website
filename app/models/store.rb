class Store < ApplicationRecord
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods

  # Relationships
  has_many :assignments
  has_many :employees, through: :assignments
  has_many :shifts, through: :assignments

  # Scopes
  scope :alphabetical, -> { order('name') }

  # Validations
  # make sure required fields are present
  validates_presence_of :name, :street, :city
  # if state is given, must be one of the choices given (no hacking this field)
  validates_inclusion_of :state, in:  %w[PA OH WV], message: "is not an option"
  # if zip included, it must be 5 digits only
  validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long"
  # phone can have dashes, spaces, dots and parens, but must be 10 digits
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  # make sure stores have unique names (case insensitive)
  validates_uniqueness_of :name, case_sensitive: false

  # Callbacks
  before_save    -> { strip_nondigits_from(:phone) }
  before_destroy -> { cannot_destroy_object() }
  
  # Misc Constants
  STATES_LIST = [['Ohio', 'OH'],['Pennsylvania', 'PA'],['West Virginia', 'WV']].freeze
  
end
