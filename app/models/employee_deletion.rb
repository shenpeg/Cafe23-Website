module EmployeeDeletion
  def handle_deletion_request 
    verify_that_never_worked_a_shift()
    if self.errors.present?
      self.destroyable = false
      throw(:abort)
    end
    remove_pending_shifts()
    remove_current_assignment()
  end

  # def handle_deletion_failure
  #   if self.destroyable == false
  #     convert_to_inactive()
  #     remove_pending_shifts()
  #     terminate_current_assignment()
  #   end
  # end

  private
  def verify_that_never_worked_a_shift
    return true if self.shifts.empty?
    unless self.shifts.finished.empty? && self.shifts.started.empty?
      errors.add(:base, 'Employee cannot be deleted because of previously worked shifts, but status has been set to inactive.')
    end
  end

  # def convert_to_inactive
  #   self.make_inactive
  # end

  def remove_pending_shifts
    return true if self.shifts.pending.empty?
    self.shifts.pending.each { |s| s.destroy }
  end

  def remove_current_assignment
    return true if self.current_assignment.nil?
    self.current_assignment.destroy
  end

  # def terminate_current_assignment
  #   self.current_assignment.terminate
  # end

end