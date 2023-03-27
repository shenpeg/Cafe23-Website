class Assignment < ApplicationRecord
  include Validations
  include Deletions

  # Relationships
  belongs_to :store
  belongs_to :employee
  belongs_to :pay_grade
  has_many :shifts 

  # Scopes
  scope :current,       -> { where('end_date IS NULL') }
  scope :past,          -> { where('end_date IS NOT NULL') }
  scope :by_store,      -> { joins(:store).order('name') }
  scope :by_employee,   -> { joins(:employee).order('last_name, first_name') }
  scope :chronological, -> { order(Arel.sql('start_date DESC, end_date IS NOT NULL, end_date DESC')) }
  scope :for_store,     ->(store) { where("store_id = ?", store.id) }
  scope :for_employee,  ->(employee) { where("employee_id = ?", employee.id) }
  scope :for_pay_grade, ->(pay_grade) { where("pay_grade_id = ?", pay_grade.id) }
  scope :for_role,      ->(role) { joins(:employee).where("role = ?", Employee.roles[role]) }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }

  # Validations
  validates_presence_of :store_id, :employee_id, :pay_grade_id, :start_date
  validates_date :start_date, on_or_before: ->{ Date.current }, on_or_before_message: "cannot be in the future"
  validates_date :end_date, after: :start_date, on_or_before: ->{ Date.current }, allow_blank: true
  validate ->{ is_active_in_system(:employee) }
  validate ->{ is_active_in_system(:store) }
  validate ->{ is_active_in_system(:pay_grade) }  # phase 4 & 5 only

  # Other methods
  def terminate
    return false unless self.end_date.nil?
    self.start_date = Date.current
    end_previous_assignment
    remove_pending_shifts
    self.reload
  end

  # Callbacks
  before_create :end_previous_assignment

  # ... for phase 4 & 5 only
  before_destroy do
    verify_no_pending_shifts
    if errors.present?
      throw(:abort)
    else
      remove_pending_shifts
    end
  end

  private
  def end_previous_assignment
    current_assignment = Employee.find(self.employee_id).current_assignment
    if current_assignment.nil?
      return true 
    else
      current_assignment.update_attribute(:end_date, self.start_date.to_date)
    end
  end

  def verify_no_pending_shifts
    unless self.shifts.started.empty? && self.shifts.finished.empty?
      errors.add(:base, "This assignments is associated with worked shifts and cannot be deleted.")
    end
  end

  def remove_pending_shifts
    self.shifts.pending.each { |s| s.destroy }
  end
end
