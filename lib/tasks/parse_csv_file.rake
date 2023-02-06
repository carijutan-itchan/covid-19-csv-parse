require 'csv'

namespace :execute_parsing do
  desc "Parse the Covid Observation data and merge it to model"

  task csv_to_model: :environment do
    file_path = "#{Rails.root}/storage/covid_19_data.csv".freeze

    #read the csv file from file path
    csv_text = File.read(file_path)

    #parse the csv
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      hash_data = row.to_hash.except("SNo")
      observation_date = Date.strptime(hash_data["ObservationDate"], "%m/%d/%Y")
      state = hash_data["Province/State"]
      country = hash_data["Country/Region"]
      last_update = hash_data["Last Update"]
      confirmed = hash_data["Confirmed"].to_i
      deaths = hash_data["Deaths"].to_i
      recovered = hash_data["Recovered"].to_i

      params = {
        observation_date: observation_date,
        state: state,
        country: country,
        last_update: last_update,
        confirmed: confirmed,
        deaths: deaths,
        recovered: recovered
      }

      covid_observation = CovidObservation.new(params)
      covid_observation.save!

      puts "successfuly created"
      puts covid_observation
    end
  end
end

