class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :website
      t.string :locale
      t.text :bio
      t.references :user, index: true

      t.timestamps
    end
  end
end
