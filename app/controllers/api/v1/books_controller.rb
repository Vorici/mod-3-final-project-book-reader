class Api::V1::BooksController < ApplicationController

  before_action :find_book, only: [:update]

def index
  books = Book.all
  render json: books
end

def update
  find_book
  @book.update(book_params)
  if @book.save
    render json: @book, status: :accepted
  else
    render json: { errors: @book.errors.full_messages }, status: :unprocessible_entity
  end
end

def show
  # currently limited to 100 - how do we get all pages?
  @page = Book.find_by(id: params[:id]).pages
  render json: @page
end

private

def book_params
  params.permit(:title, :content)
end

def find_book
  @book = Book.find(params[:id])
end
end
