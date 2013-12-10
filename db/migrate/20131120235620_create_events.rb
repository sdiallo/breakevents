class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :fb_eid
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :picture
      t.string :ticket_uri

      t.timestamps
    end
  end
end
