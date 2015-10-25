class CreateMoviesLocations < ActiveRecord::Migration
  def change
    create_table :movies_locations do |t|
      t.references :location, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
