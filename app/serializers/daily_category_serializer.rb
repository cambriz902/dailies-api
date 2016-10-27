class DailyCategorySerializer < ActiveModel::Serializer
  attributes :id, :kind, :total_points, :archived

  has_one :user
end
