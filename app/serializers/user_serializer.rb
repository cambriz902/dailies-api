class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token
  embed :ids

  has_many :daily_categories
end
