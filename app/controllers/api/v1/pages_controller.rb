class Api::V1::PagesController < ApplicationController
  before_action :find_page, only: [:update]

  def index
    pages = Page.all
    render json: pages
  end

  def update
    find_page
    @page.update(page_params)
    if @page.save
      render json: @page, status: :accepted
    else
      render json: { errors: @page.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def show
    @page = Page.find_by(book_id: params[:id])
    render json: @page
  end

  private

  def page_params
    params.require(:page).permit(:url)
  end

  def find_page
    @page = Page.find(params[:id])
  end
end
