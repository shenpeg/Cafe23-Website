class ShiftJob < ApplicationRecord
  include Validations

  # Relationships
  belongs_to :shift
  belongs_to :job

  # Scopes
  scope :alphabetical, -> { joins(:job).order('name') }

  # Validations
  validates_presence_of :shift_id, :job_id
  validate ->{ is_active_in_system(:job) }
  validate ->{ is_active_in_system(:shift) }
  validate :only_shifts_that_are_over
  
  private  
  def only_shifts_that_are_over
    return true if self.shift_id.nil? || self.job_id.nil?
    # if self.shift.date.future? || (self.shift.date.today? && self.shift.end_time.future?)
    unless self.shift.status == 'finished'
      errors.add(:shift_id, "is not yet complete. Try again when shift has ended.")
    end
  end
  
end
