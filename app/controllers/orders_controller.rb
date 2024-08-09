class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  def new
    @order = Order.new
    @order.build_address
    cart = session[:cart] || {}
    cart_items = cart["items"] || []
    Rails.logger.debug "Cart items: #{cart_items.inspect}"
    cart_items.each do |cart_item|
      Rails.logger.debug "Processing cart item: #{cart_item.inspect}"
      product_id = cart_item["product_id"].to_i # Ensure product_id is an integer
      Rails.logger.debug "Converted product_id: #{product_id}"
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: cart_item["quantity"].to_i, price: product.price)
    end
  end

  def create
    @order = Order.new(order_params)
    Rails.logger.debug "Order params: #{order_params.inspect}"
    Rails.logger.debug "Order items before save: #{@order.order_items.inspect}"

    if @order.save
      Rails.logger.debug "Order created with items: #{@order.order_items.inspect}"
      session[:cart] = nil  # Clear the cart after successful order creation
      redirect_to @order, notice: 'Order was successfully created.'
    else
      Rails.logger.debug "Order creation failed: #{@order.errors.full_messages.join(", ")}"
      @order.order_items.each do |item|
        Rails.logger.debug "OrderItem errors: #{item.errors.full_messages.join(", ")}"
      end
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    Rails.logger.debug "Order items: #{@order.order_items.inspect}"
  end

  def index
    @orders = Order.all
  end

  private

  def order_params
    params.require(:order).permit(
      :name,
      :email,
      address_attributes: [:street, :city, :province, :postal_code],
      order_items_attributes: [:product_id, :quantity, :price]
    )
  end
end
