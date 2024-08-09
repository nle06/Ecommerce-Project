class AddGuestDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
  end
end
