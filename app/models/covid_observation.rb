class CovidObservation < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_obsercation_date, against: :observation_date
end
