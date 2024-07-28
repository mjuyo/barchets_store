class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product
  
    validates :quantity, :price, presence: true
    
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "gst_rate", "hst_rate", "id", "id_value", "order_id", "price", "product_id", "pst_rate", "qst_rate", "quantity", "updated_at"]
    end
  end
  