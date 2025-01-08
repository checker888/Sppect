class Space < ApplicationRecord
  belongs_to :owner, class_name: "Owner", foreign_key: "owner_id"
  has_many :space_genre_relations
  has_many :genres, through: :space_genre_relations
  has_many :space_facility_relations
  has_many :facilities, through: :space_facility_relations
  has_many :reservations
  has_many :reviews,dependent: :destroy
  has_many :likes,dependent: :destroy
end
