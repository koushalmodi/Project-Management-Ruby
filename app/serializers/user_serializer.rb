class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email
  has_one :profile
end
