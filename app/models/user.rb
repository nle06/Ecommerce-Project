class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :orders
end
