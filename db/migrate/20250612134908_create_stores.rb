class CreateStores < ActiveRecord::Migration[8.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
