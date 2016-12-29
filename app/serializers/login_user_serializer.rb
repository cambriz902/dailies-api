class LoginUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token

  has_many :daily_categories
  has_many :today_dailies, through: :daily_categories
end
