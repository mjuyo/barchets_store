class Price < ApplicationRecord
    belongs_to :product
  
    validates :price, :start_date, presence: true
  end
  