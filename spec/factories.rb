FactoryBot.define do
  factory :covid_observation do
    observation_date { '2022-02-01' }
    state  { 'manila' }
    country { 'philippines'}
    last_update { '2022-02-01' }
    confirmed { 1 }
    deaths { 1 }
    recovered { 1 }
  end
end 
