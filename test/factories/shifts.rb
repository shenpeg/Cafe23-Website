FactoryBot.define do
  factory :shift do
    association :assignment
    date { Date.current }
    start_time { Time.local(2000,1,1,11,0,0) }
    end_time { Time.local(2000,1,1,14,0,0) }
    status { 1 }
    notes { 'This was a great shift and enjoyed by all who chose to partake.' }
  end
end