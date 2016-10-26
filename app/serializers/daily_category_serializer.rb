class DailyCategorySerializer < ActiveModel::Serializer
  attributes :id, :kind, :total_points, :archived
end
