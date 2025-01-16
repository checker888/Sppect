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
    def search(query,start_time, end_time,genre_ids,facility_ids)
      rel = order("id")
      if query.present?
        rel = rel.where("title LIKE ? OR subtitle LIKE ? OR detail LIKE ?",
          "%#{query}%", "%#{query}%", "%#{query}%")
      end
      if genre_ids.present?
        rel = rel.joins(:genres).where(space_genre_relations: {genre_id: genre_ids })
      end

      if facility_ids.present?
        rel = rel.joins(:facilities).where(space_facility_relations: {facility_id: facility_ids })
                    .group("spaces.id")  # 重複を避けるためスペースIDでグループ化
                    .having("COUNT(facilities.id) = ?", facility_ids.size)
      end
      # 時間範囲で絞り込み
      # if start_time.present? && end_time.present?
      #   rel = rel.where(
      #     "(available_start_time <= ? AND available_end_time >= ?) OR " +
      #     "(available_start_time > available_end_time AND " +
      #     "(? >= available_start_time OR ? <= available_end_time))",
      #     start_time, end_time, start_time, end_time
      #   )
      # else
      #   # puts rel
      # end
      rel
    end

  end
end
