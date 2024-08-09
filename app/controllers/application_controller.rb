class ApplicationController < ActionController::Base
  helper_method :current_cart
  before_action :authenticate_user!
  def current_cart
    session[:cart] || { "items" => [] }
  end
end
