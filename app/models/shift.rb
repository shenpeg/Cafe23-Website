class Shift < ApplicationRecord
  include Validations
  include Deletions

  # Relationships
  belongs_to :assignment
  has_one :employee, through: :assignment
  has_one :store, through: :assignment
  has_many :shift_jobs #, dependent: :destroy
  has_many :jobs, through: :shift_jobs

  # Enums
  enum :status, { pending: 1, started: 2, finished: 3 }, scopes: true, default: :pending

  # Scopes
  scope :completed,     -> { joins(:shift_jobs).group(:shift_id) }
  scope :incomplete,    -> { joins("LEFT JOIN shift_jobs ON shifts.id = shift_jobs.shift_id").where('shift_jobs.job_id IS NULL') }
  # alternative ways of finding 'incomplete' scope:
  # scope :incomplete,  -> { where('id NOT IN (?)', Shift.completed.map(&:id)) }
  # also see the class method 'not_completed' further on down...
  scope :for_store,     ->(store) { joins(:assignment, :store).where("assignments.store_id = ?", store.id) }
  scope :for_employee,  ->(employee) { joins(:assignment, :employee).where("assignments.employee_id = ?", employee.id) }
  scope :past,          -> { where('date < ?', Date.current) }
  scope :upcoming,      -> { where('date >= ?', Date.current) }
  scope :for_next_days, ->(x) { where('date BETWEEN ? AND ?', Date.current, x.days.from_now.to_date) }
  scope :for_past_days, ->(x) { where('date BETWEEN ? AND ?', x.days.ago.to_date, 1.day.ago.to_date) }
  scope :chronological, -> { order(:date, :start_time) }
  scope :by_store,      -> { joins(:assignment, :store).order(:name) }
  scope :by_employee,   -> { joins(:assignment, :employee).order(:last_name, :first_name) }
  # scope not in phase 3 requirements (b/c uses date range object)
  scope :for_dates,     ->(date_range) { where('date BETWEEN ? AND ?', date_range.start_date, date_range.end_date) }


  # Validations
  validates_date :date, on_or_after: lambda { :assignment_starts }, on_or_after_message: "must be on or after the start of the assignment"
  validates_time :start_time #, between: [Time.local(2000,1,1,11,0,0), Time.local(2000,1,1,23,0,0)]
  validates_time :end_time, after: :start_time, allow_blank: true
  validates_inclusion_of :status, in: statuses.keys, message: "is not an option"
  validate :assignment_must_be_current, on: :create
  validates_presence_of :assignment_id

  # Other methods
  def report_completed?
    self.shift_jobs.count > 0
  end
  
  # method uses the date_time_helpers gem; https://github.com/profh/time_date_helpers
  def duration
    (round_minutes(self.end_time) - round_minutes(self.start_time, direction: :down))/3600.0
  end
  
  # Callbacks
  # set default end_time (on create only)
  before_create :set_shift_end_time

  # allow shifts to only be deleted if status is 'pending'
  before_destroy do
    verify_shift_is_pending
    if errors.present?
      throw(:abort)
    end
  end

  # Misc Constants (for view dropdowns)
  STATUS_LIST = [['Pending', 'pending'],['Started', 'started'],['Finished', 'finished']].freeze


  private
  def assignment_starts
    @assignment_starts = self.assignment.start_date.to_date
  end
  
  def assignment_must_be_current
    return true if self.assignment.nil?
    unless self.assignment.end_date.nil?
      errors.add(:assignment_id, "is not a current assignment at the creamery")
    end
  end
  
  def set_shift_end_time
    return true unless self.end_time.nil? 
    self.end_time = self.start_time + (3*60*60)
  end

  def verify_shift_is_pending
    unless self.status == 'pending'
      errors.add(:base, "This shift either has begun or has finished and cannot be deleted.")
    end
  end
  
end

