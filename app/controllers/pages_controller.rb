class PagesController < ApplicationController
  def about
    @page = Page.find_by(title: 'About Us')
    render :show
  end

  def contact
    @page = Page.find_by(title: 'Contact Us')
    render :show
  end

  def show
    @page = Page.find(params[:id])
  end
end
