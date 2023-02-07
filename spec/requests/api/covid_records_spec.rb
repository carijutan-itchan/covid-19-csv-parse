require 'rails_helper'
require 'faker'

RSpec.describe "Api::CovidRecords", type: :request do

  describe "GET /top/confirmed" do
    subject do
      get top_confirmed_path(observation_date: observation_date, max_results: max_results)
      response
    end

    let(:observation_date) { '2022-02-05' }
    let(:max_results) { 3 }
    let(:state) { Faker::Address.state }
    let(:country) { Faker::Address.country }
    let(:last_update) { '2022-02-05' }
    let(:confirmed) { 2 }
    let(:deaths) { 5 }
    let(:recovered) { 10 }


    context 'when exists both parameters' do

      before do
        create_list(
          :covid_observation, 10,
          observation_date: observation_date,
          state: state,
          country: country,
          last_update: last_update,
          confirmed: confirmed,
          deaths: deaths,
          recovered: recovered
        )
      end

      it 'returns 200 status' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body).size).to eq 3 #return the size of json response with default max_results
      end

      it 'returns covid_observation records' do
        covid_observation = CovidObservation.first
        expect(subject).to have_http_status(:ok)

        expect(Date.parse(JSON.parse(subject.body)[0]["observation_date"])).to eq covid_observation.observation_date.to_date
        expect(JSON.parse(subject.body)[0]["countries"]["country"]).to eq covid_observation.country
        expect(JSON.parse(subject.body)[0]["countries"]["confirmed"]).to eq covid_observation.confirmed
        expect(JSON.parse(subject.body)[0]["countries"]["deaths"]).to eq covid_observation.deaths
        expect(JSON.parse(subject.body)[0]["countries"]["recovered"]).to eq covid_observation.recovered
      end

      context 'when max_result params is equal 2' do
        let(:max_results) { 2 }
  
        it 'return a number of data based on max_results' do
          expect(subject).to have_http_status(:ok)
          expect(JSON.parse(subject.body).size).to eq 2
        end
      end
    end

    context 'when bosth params is empty' do
      let(:max_results) { }
      let(:observation_date) { }

      before do
        create_list(
          :covid_observation, 10,
          observation_date: observation_date,
          state: state,
          country: country,
          last_update: last_update,
          confirmed: confirmed,
          deaths: deaths,
          recovered: recovered
        )
      end

      it 'return a number of data based on max_results' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body).size).to eq 10 #it will return all the list
      end
    end

    context 'when observation params only exist' do
      let(:observation_date) {'2022-03-05' }
      let(:max_results) { }

      before do
        create_list(
          :covid_observation, 5,
          observation_date: observation_date,
          state: state,
          country: country,
          last_update: last_update,
          confirmed: confirmed,
          deaths: deaths,
          recovered: recovered
        )
      end

      it 'return record within the observation date' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body).size).to eq 5
      end
    end
  end
end
