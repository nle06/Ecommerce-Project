class CartController < ApplicationController
  def add
    product = Product.find(params[:id])
    session[:cart] ||= { "items" => [] }
    existing_item = session[:cart]["items"].find { |item| item["product_id"] == product.id.to_s }

    if existing_item
      existing_item["quantity"] += 1
      flash[:notice] = "Updated quantity of #{product.name} in your cart."
    else
      session[:cart]["items"] << { "product_id" => product.id.to_s, "quantity" => 1 }
      flash[:notice] = "Added #{product.name} to your cart."
    end

    redirect_to cart_path
  end

  def show
    @cart = session[:cart] || { "items" => [] }
    if @cart["items"].is_a?(Array)
      product_ids = @cart["items"].map { |item| item["product_id"] }
      @products = Product.where(id: product_ids)
    else
      @products = []
      flash[:error] = "Cart items are not properly formatted."
    end
  end

  def remove
    product_id = params[:id].to_s
    session[:cart]["items"].delete_if { |item| item["product_id"] == product_id }
    flash[:notice] = "Removed item from your cart."

    Rails.logger.debug("Cart after removing: #{session[:cart].inspect}")

    respond_to do |format|
      format.html { redirect_to cart_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  def update_quantity
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i
    item = session[:cart]["items"].find { |i| i["product_id"] == product_id }
    if item
      item["quantity"] = quantity
      flash[:notice] = "Updated quantity for item."
    else
      flash[:error] = "Item not found in cart."
    end

    redirect_to cart_path
  end
end
