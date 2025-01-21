class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :prefix
      t.integer :role
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
