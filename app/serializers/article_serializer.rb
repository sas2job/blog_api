# frozen_string_literal: true

class ArticleSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :body, :category, :published_date, :user_id
  set_key_transform :camel_lower
end
