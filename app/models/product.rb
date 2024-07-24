class Product < ApplicationRecord
    has_many :category_products
    has_many :categories, through: :category_products
    has_many :order_products
    has_many :orders, through: :order_products
    has_many :prices
    has_one_attached :image

    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :stock_quantity, presence: true

    scope :on_sale, -> { where(on_sale: true) }
    scope :new_products, ->  { where('created_at >= ?', 3.days.ago) }
    scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where.not('created_at >= ?', 3.days.ago) }

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "price", "stock_quantity", "updated_at", "on_sale"]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[categories category_products image_attachment image_blob]
    end
end

