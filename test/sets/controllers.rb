module Contexts
  module Controllers

    def create_controller_context
      @ben = FactoryBot.create(:employee, first_name: "Ben", last_name: "Sisko", username: "ben", role: "manager")
      @ralph = FactoryBot.create(:employee, first_name: "Ralph", last_name: "Wilson", username: "ralph", date_of_birth: 16.years.ago.to_date)
      @ed = FactoryBot.create(:employee)
      @downtown = FactoryBot.create(:store, name: "Downtown")
      @t1 = FactoryBot.create(:pay_grade, level: "T1")
    end

    def create_manager_context
      create_controller_context
      @uptown = FactoryBot.create(:store, name: "Uptown")
      # assign both ben and ralph to downtown store
      @assign_ben = FactoryBot.create(:assignment, employee: @ben, store: @downtown, start_date: 10.months.ago.to_date, end_date: nil, pay_grade: @t1)
      @assign_ralph = FactoryBot.create(:assignment, employee: @ralph, store: @downtown, start_date: 10.months.ago.to_date, end_date: nil, pay_grade: @t1)
      # assign ed to uptown store
      @assign_ed = FactoryBot.create(:assignment, employee: @ed, store: @uptown, start_date: 10.months.ago.to_date, end_date: nil, pay_grade: @t1)
    end
    
    def create_employee_context
      create_controller_context
      @t2 = FactoryBot.create(:pay_grade, level: "T2")
      # initial assignments for ed and ralph
      @assign_ed = FactoryBot.create(:assignment, employee: @ed, store: @downtown, start_date: 10.months.ago.to_date, end_date: 10.days.ago.to_date, pay_grade: @t1)
      @assign_ralph = FactoryBot.create(:assignment, employee: @ralph, store: @downtown, start_date: 10.months.ago.to_date, end_date: 10.days.ago.to_date, pay_grade: @t1)
      # current assignments for ed and ralph (same place, higher grade)
      @assign_ed_2 = FactoryBot.create(:assignment, employee: @ed, store: @downtown, start_date: 10.days.ago.to_date, end_date: nil, pay_grade: @t2)
      @assign_ralph_2 = FactoryBot.create(:assignment, employee: @ralph, store: @downtown, start_date: 10.days.ago.to_date, end_date: nil, pay_grade: @t2)  
    end

  end
end