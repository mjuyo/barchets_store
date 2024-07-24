class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :product_id, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date

      t.timestamps
    end

    add_foreign_key :prices, :products
  end
end
