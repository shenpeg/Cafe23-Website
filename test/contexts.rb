# require needed files
require './test/sets/employees'
require './test/sets/stores'
require './test/sets/assignments'
require './test/sets/pay_grades'
require './test/sets/pay_grade_rates'
require './test/sets/shifts'
require './test/sets/jobs'
require './test/sets/shift_jobs'
require './test/sets/abilities'
require './test/sets/controllers'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Employees
  include Contexts::Stores
  include Contexts::Jobs
  include Contexts::PayGrades
  include Contexts::PayGradeRates
  include Contexts::Assignments
  include Contexts::Shifts
  include Contexts::ShiftJobs
  include Contexts::Abilities
  include Contexts::Controllers
  
  def create_all
    # puts "Building context..."
    create_employees
    # puts "Built employees"
    create_stores
    # puts "Built stores"
    create_jobs
    # puts "Built jobs"
    create_pay_grades
    # puts "Built pay grades"
    create_pay_grade_rates
    # puts "Built pay grade rates"
    create_assignments
    # puts "Built assignments"
    create_shifts
    # puts "Built shifts"
    create_shift_jobs
    # puts "Built shift jobs"

  end
  
end