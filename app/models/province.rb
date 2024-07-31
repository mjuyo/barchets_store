class Province < ApplicationRecord
    has_many :customers

    validates :name, presence: true
    validates :gst_rate, :pst_rate, :hst_rate, :qst_rate, numericality: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "gst_rate", "hst_rate", "id", "id_value", "name", "pst_rate", "qst_rate", "updated_at"]
    end
end
  