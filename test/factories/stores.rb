FactoryBot.define do
  factory :store do
    name { 'CMU' }
    street { '5000 Forbes Avenue' }
    city { 'Pittsburgh' }
    state { 'PA' }
    zip { '15213' }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active { true }
  end
end
