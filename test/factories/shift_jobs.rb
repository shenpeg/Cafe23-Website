FactoryBot.define do
  factory :shift_job do
    association :shift
    association :job
  end
end