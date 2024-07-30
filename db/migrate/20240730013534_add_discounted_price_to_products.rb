class AddDiscountedPriceToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :discounted_price, :decimal
  end
end
