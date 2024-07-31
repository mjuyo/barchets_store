class Product < ApplicationRecord
    has_many :category_products
    has_many :categories, through: :category_products
    has_many :order_products
    has_many :orders, through: :order_products
    has_many :prices
    has_one_attached :image

    validates :name, :description, :price, :stock_quantity, presence: true
    validates :price, :discounted_price, numericality: true
    validates :stock_quantity, numericality: { only_integer: true }

    scope :on_sale, -> { where(on_sale: true) }
    scope :new_products, ->  { where('created_at >= ?', 3.days.ago) }
    scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where.not('created_at >= ?', 3.days.ago) }

    # Image resizing
    def large_image
        image.variant(resize_to_limit: [320, 320])
    end
    
    def medium_image
        image.variant(resize_to_limit: [200, 200])
    end

    def thumbnail_image
        image.variant(resize_to_limit: [80, 80])
    end

    # Stock level
    def stock_level
        if stock_quantity > 50
            { level: 'High', color: 'green' }
          elsif stock_quantity > 10
            { level: 'Medium', color: 'orange' }
          else
            { level: 'Low', color: 'red' }
          end
      end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "price", "discounted_price", "stock_quantity", "updated_at", "on_sale"]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[categories category_products image_attachment image_blob]
    end
end

