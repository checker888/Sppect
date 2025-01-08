class Space < ApplicationRecord
  belongs_to :owner, class_name: "Owner", foreign_key: "owner_id"
  has_many :space_genre_relations,dependent: :destroy
  has_many :genres, through: :space_genre_relations
  has_many :space_facility_relations,dependent: :destroy
  has_many :facilities, through: :space_facility_relations
  has_many :reservations
  has_many :reviews,dependent: :destroy
  has_many :likes,dependent: :destroy

  validates :title,presence: true,
  length: { minimum: 3, maximum: 30}

  validates :subtitle,
  length: { maximum: 50, allow_blank: true }

  validates :detail,
  length: { maximum: 500, allow_blank: true }


  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("title LIKE ? OR subtitle LIKE ? OR detail LIKE ?",
          "%#{query}%", "%#{query}%", "%#{query}%")
      end
      rel
    end

  end
end
