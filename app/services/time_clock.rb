class TimeClock
  def initialize(shift)
    @shift = shift
  end

  attr_reader :shift

  def start_shift_at(time=Time.now)
    return false unless shift.pending?
    shift.start_time = Time.local(2000,1,1, time.hour, time.min, 0)
    shift.end_time = nil
    shift.status = 'started'
    shift.save
  end

  def end_shift_at(time=Time.now)
    return false unless shift.started?
    shift.end_time = Time.local(2000,1,1, time.hour, time.min, 0)
    shift.status = 'finished'
    shift.save
  end

end