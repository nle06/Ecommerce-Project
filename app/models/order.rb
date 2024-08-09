class Order < ApplicationRecord
  has_many :order_items
  has_one :address

  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, presence: true

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.price) : 0 }.sum
  end

  def taxes
    if address && address.province.present?
      province = address.province.downcase
      tax_rates = {
        'alberta' => { gst: 0.05, pst: 0, hst: 0 },
        'british columbia' => { gst: 0.05, pst: 0.07, hst: 0 },
        'manitoba' => { gst: 0.05, pst: 0.07, hst: 0 },
        'new brunswick' => { gst: 0, pst: 0, hst: 0.15 },
        'newfoundland and labrador' => { gst: 0, pst: 0, hst: 0.15 },
        'northwest territories' => { gst: 0.05, pst: 0, hst: 0 },
        'nova scotia' => { gst: 0, pst: 0, hst: 0.15 },
        'nunavut' => { gst: 0.05, pst: 0, hst: 0 },
        'ontario' => { gst: 0, pst: 0, hst: 0.13 },
        'prince edward island' => { gst: 0, pst: 0, hst: 0.15 },
        'quebec' => { gst: 0.05, pst: 0.09975, hst: 0 },
        'saskatchewan' => { gst: 0.05, pst: 0.06, hst: 0 },
        'yukon' => { gst: 0.05, pst: 0, hst: 0 }
      }

      rates = tax_rates[province] || { gst: 0, pst: 0, hst: 0 }
      subtotal * (rates[:gst] + rates[:pst] + rates[:hst])
    else
      0
    end
  end

  def total
    subtotal + taxes
  end
end
