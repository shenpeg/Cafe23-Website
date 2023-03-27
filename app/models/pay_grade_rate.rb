class PayGradeRate < ApplicationRecord
  include Validations
  include Deletions

  # Relationships
  belongs_to :pay_grade

  # Scopes
  scope :current,        -> { where('end_date IS NULL') }
  scope :chronological,  -> { order('start_date') }
  scope :for_pay_grade,  ->(pay_grade) { where('pay_grade_id = ?', pay_grade.id) }
  scope :for_date,       ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }

  # Validations
  validates_numericality_of :rate, greater_than: 0
  validate ->{ is_active_in_system(:pay_grade) }

  # Callbacks
  before_destroy -> { cannot_destroy_object() }
  before_create :end_previous_rate

  private
  def end_previous_rate
    current_rate = PayGrade.find(self.pay_grade_id).current_rate
    if current_rate.nil?
      return true 
    else
      current_rate.update_attribute(:end_date, self.start_date.to_date)
    end
  end

end
