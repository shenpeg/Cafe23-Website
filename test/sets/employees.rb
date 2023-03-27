module Contexts
  module Employees

    def create_employees
      @ed = FactoryBot.create(:employee)
      @cindy = FactoryBot.create(:employee, first_name: "Cindy", last_name: "Crawford", username: "cindy", ssn: "084-35-9822", date_of_birth: 17.years.ago.to_date)
      @ralph = FactoryBot.create(:employee, first_name: "Ralph", last_name: "Wilson", username: "ralph", date_of_birth: 16.years.ago.to_date)
      @chuck = FactoryBot.create(:employee, first_name: "Chuck", last_name: "Waldo", username: "chuck", date_of_birth: 26.years.ago.to_date, active: false)
      @ben = FactoryBot.create(:employee, first_name: "Ben", last_name: "Sisko", username: "ben", role: "manager", :phone => "412-268-2323")
      @kathryn = FactoryBot.create(:employee, first_name: "Kathryn", last_name: "Janeway", username: "kathryn", role: "manager", ssn: "082 86 9198", date_of_birth: 30.years.ago.to_date)
      @alex = FactoryBot.create(:employee, first_name: "Alex", username: "alex", last_name: "Heimann", role: "admin")
    end
    
    def destroy_employees
      @ed.destroy
      @cindy.destroy
      @ralph.destroy
      @chuck.destroy  
      @ben.destroy
      @kathryn.destroy
      @alex.destroy
    end

  end
end