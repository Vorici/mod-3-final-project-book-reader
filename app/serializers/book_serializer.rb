class BookSerializer < ActiveModel::Serializer
  attributes :id, :book_num, :image_count, :title, :authors, :year, :publisher, :isbn, :api_image_count
  belongs_to :user
end
