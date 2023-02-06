class CreateCovidObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :covid_observations do |t|
      t.datetime :observation_date
      t.string :state
      t.string :country
      t.datetime :last_update
      t.integer :confirmed
      t.integer :deaths
      t.integer :recovered
      t.timestamps
    end
  end
end
