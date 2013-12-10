class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.string :name
      t.references :event, index: true

      t.timestamps
    end
  end
end
