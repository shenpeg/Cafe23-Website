FactoryBot.define do
  factory :pay_grade_rate do
    association :pay_grade
    rate { 9.95 }
    start_date { 1.year.ago.to_date }
    end_date { nil }
  end
end