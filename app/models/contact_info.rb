class ContactInfo < ApplicationRecord

    validates :address, :email, :phone, :open_hours, presence: true
    
    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "email", "id", "id_value", "open_hours", "phone", "updated_at"]
    end
end
