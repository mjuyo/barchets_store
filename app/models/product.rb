class Product < ApplicationRecord
    has_many :category_products
    has_many :categories, through: :category_products
    has_one_attached :image

    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :stock_quantity, presence: true
end

