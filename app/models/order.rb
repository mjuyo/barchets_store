class Order < ApplicationRecord
    belongs_to :customer
    belongs_to :province
    has_many :order_products
    has_many :products, through: :order_products
  
    validates :order_date, :status, :total_price, :total_tax, :address, :province_id, presence: true

    def calculate_total_price
        self.total_price = order_products.sum('quantity * price')
    end
    
    def calculate_total_tax
        province = Province.find(province_id)
        self.total_tax = (total_price * province.pst_rate / 100) + (total_price * province.gst_rate / 100) + (total_price * province.hst_rate / 100)
    end

    def self.ransackable_associations(auth_object = nil)
        ["customer", "order_products", "products", "province"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "customer_id", "id", "id_value", "order_date", "province_id", "status", "total_price", "total_tax", "updated_at"]
    end
  end
  