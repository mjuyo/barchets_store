class Price < ApplicationRecord
  belongs_to :product

  validates :price, presence: true, numericality: true
  validates :start_date, presence: true
end
