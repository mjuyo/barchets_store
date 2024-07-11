class Product < ApplicationRecord
    has_many :category_products
    has_many :categories, through: :category_products
    has_one_attached :image

    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :stock_quantity, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "price", "stock_quantity", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[categories category_products image_attachment image_blob]
    end
end

