class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false                           # 名前
      t.date :birthday, null: false
      t.string :address, null: false
      t.string :phonenumber, null: false
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
