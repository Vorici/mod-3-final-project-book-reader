class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :content

  belongs_to :user
end
