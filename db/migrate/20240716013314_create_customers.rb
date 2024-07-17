class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :address
      t.integer :province_id
      t.string :phone_number

      t.timestamps
    end
    add_index :customers, :email, unique: true
    add_foreign_key :customers, :provinces
  end
end
