class Job < ApplicationRecord
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods

  # Relationships
  has_many :shift_jobs
  has_many :shifts, through: :shift_jobs

  # Scopes
  scope :alphabetical, -> { order('name') }

  # Validations
  validates_presence_of :name

  # Other methods

  # Callback - allow jobs to only be deleted if never worked on a shift
  before_destroy do
    verify_no_shifts_associated_with_job
    if errors.present?
      throw(:abort)
    end
  end

  private 

  def verify_no_shifts_associated_with_job
    unless self.shift_jobs.empty?
      errors.add(:base, "This job has been worked before and cannot be deleted now.")
    end
  end
  
end
