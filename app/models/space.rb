class Space < ApplicationRecord
  belongs_to :owner, class_name: "Owner", foreign_key: "owner_id"
  has_many :space_category_relations
  has_many :categories, through: :space_category_relations
  has_many :reservations
  has_many :reviews,dependent: :destroy
  has_many :likes,dependent: :destroy
end
