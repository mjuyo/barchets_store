class Customer < ApplicationRecord
    belongs_to :province
    has_many :orders
    
    validates :first_name, :last_name, :email, :province_id, presence: true
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
end
  