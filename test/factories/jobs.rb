FactoryBot.define do
  factory :job do
    name { 'Cashier' }
    description { 'Working the cash register' }
    active { true }
  end
end