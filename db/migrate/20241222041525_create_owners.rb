class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.date :birthday, null: false
      t.string :address, null: false
      t.string :phonenumber, null: false
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
