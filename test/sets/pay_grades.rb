module Contexts
  module PayGrades

    def create_pay_grades
      @m1 = FactoryBot.create(:pay_grade, level: "M1")
      @m2 = FactoryBot.create(:pay_grade, level: "M2")
      @c0 = FactoryBot.create(:pay_grade, level: "C0", active: false)
      @c1 = FactoryBot.create(:pay_grade, level: "C1")
      @c2 = FactoryBot.create(:pay_grade, level: "C2")
      @c3 = FactoryBot.create(:pay_grade, level: "C3")
    end
    
    def destroy_pay_grades
      @c0.destroy
      @c1.destroy
      @c2.destroy
      @c3.destroy
      @m1.destroy
      @m2.destroy
    end

  end
end