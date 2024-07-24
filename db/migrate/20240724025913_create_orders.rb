class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.datetime :order_date, null: false
      t.string :status, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.decimal :total_tax, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_foreign_key :orders, :customers
  end
end
