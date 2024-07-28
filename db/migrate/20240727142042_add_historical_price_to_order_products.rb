class AddHistoricalPriceToOrderProducts < ActiveRecord::Migration[7.1]
  def change
    
    add_column :order_products, :gst_rate, :decimal
    add_column :order_products, :pst_rate, :decimal
    add_column :order_products, :hst_rate, :decimal
    add_column :order_products, :qst_rate, :decimal
  end
end
