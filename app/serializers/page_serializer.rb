class PageSerializer < ActiveModel::Serializer
  attributes :id, :url, :file_id, :file_name
end
