module Contexts
  module Assignments

    def create_assignments
      @assign_ed = FactoryBot.create(:assignment, employee: @ed, store: @cmu, pay_grade: @c1)
      @assign_ralph = FactoryBot.create(:assignment, employee: @ralph, store: @oakland, start_date: 10.months.ago.to_date, end_date: nil, pay_grade: @c1)
      @assign_cindy = FactoryBot.create(:assignment, employee: @cindy, store: @cmu, start_date: 14.months.ago.to_date, end_date: nil, pay_grade: @c1)
      @assign_ben = FactoryBot.create(:assignment, employee: @ben, store: @cmu, start_date: 2.years.ago.to_date, end_date: 6.months.ago.to_date, pay_grade: @m1)
      @promote_ben = FactoryBot.create(:assignment, employee: @ben, store: @cmu, start_date: 6.months.ago.to_date, end_date: nil, pay_grade: @m2)
      @assign_kathryn = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, start_date: 10.months.ago.to_date, end_date: nil, pay_grade: @m1)
    end
    
    def destroy_assignments
      @assign_ed.destroy
      @assign_ralph.destroy
      @assign_cindy.destroy
      @assign_ben.destroy
      @promote_ben.destroy
      @assign_kathryn.destroy
    end

  end
end