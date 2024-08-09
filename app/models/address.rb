class Address < ApplicationRecord
  belongs_to :order

  validates :street, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true
end
