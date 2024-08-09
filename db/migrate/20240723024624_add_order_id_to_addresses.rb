class AddOrderIdToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :order, foreign_key: true, null: true
  end
end
