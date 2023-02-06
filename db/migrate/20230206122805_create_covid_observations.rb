class CreateCovidObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :covid_observations do |t|

      t.timestamps
    end
  end
end
