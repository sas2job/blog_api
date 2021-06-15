# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email
  set_key_transform :camel_lower
end
