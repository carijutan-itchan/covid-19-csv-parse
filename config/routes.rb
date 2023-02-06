Rails.application.routes.draw do
  get 'top/confirmed', to: 'api/covid_records#index'
end
