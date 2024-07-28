class Order < ApplicationRecord
    belongs_to :customer
    belongs_to :province
    has_many :order_products, dependent: :destroy
    has_many :products, through: :order_products
  
    validates :order_date, :status, :sub_total_price,:total_price, :total_tax, :address, :province_id, presence: true

    def calculate_sub_total_price
        self.sub_total_price = order_products.sum('quantity * price')
    end
    
    def calculate_total_tax
        province = Province.find(province_id)
        self.total_tax = (sub_total_price * province.pst_rate / 100) + (sub_total_price * province.gst_rate / 100) + (sub_total_price * province.hst_rate / 100)  + (sub_total_price * province.qst_rate / 100)
    end

    def calculate_total_price
        (sub_total_price || 0) + (total_tax || 0)
    end


    def self.ransackable_associations(auth_object = nil)
        ["customer", "order_products", "products", "province"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "customer_id", "id", "id_value", "order_date", "province_id", "status", "sub_total_price", "total_price", "total_tax", "updated_at"]
    end

    # Add columns for status and payment_id
    # t.string :status, default: 'pending'
    # t.string :payment_id
  end
  