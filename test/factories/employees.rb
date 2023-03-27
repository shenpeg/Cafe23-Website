FactoryBot.define do
  factory :employee do
    first_name { 'Ed' }
    last_name { 'Gruberman' }
    ssn { rand(9 ** 9).to_s.rjust(9,'0') }
    date_of_birth {19.years.ago.to_date}
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    role { 1 }
    active { true }
    sequence :username do |n|
      "user#{n}"
    end
    password { 'secret' }
    password_confirmation { 'secret' }
  end
end