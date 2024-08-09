# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago).order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description price stock_quantity category_id on_sale sale_price]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category]
  end
end
