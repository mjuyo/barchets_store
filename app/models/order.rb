class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_products
    has_many :products, through: :order_products
  
    validates :order_date, :status, :total_price, :total_tax, presence: true
  end
  