class PayGrade < ApplicationRecord
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods

  # Relationships
  has_many :assignments
  has_many :pay_grade_rates

  # Scopes
  scope :alphabetical, -> { order('level') }

  # Validations
  validates_presence_of :level
  validates_uniqueness_of :level, case_sensitive: false
  
  # Methods
  def current_rate 
    self.pay_grade_rates.current.first
  end

  # Callbacks
  before_destroy -> { cannot_destroy_object() }
  
end
