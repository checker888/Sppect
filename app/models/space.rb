class Space < ApplicationRecord
  belongs_to :owner, class_name: "Owner", foreign_key: "owner_id"
  has_many :space_category_relations
  has_many :category, through: :space_category_relations
end
