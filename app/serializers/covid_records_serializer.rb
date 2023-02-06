class CovidRecordsSerializer < ActiveModel::Serializer
  attributes :observation_date, :countries

  def countries
      {
        country: object.country,
        confirmed: object.confirmed,
        deaths: object.deaths,
        recovered: object.recovered
      }
  end
end