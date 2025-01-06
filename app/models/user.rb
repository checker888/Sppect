class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :nullify
  has_many :reviews,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :liked_spaces, through: :likes, source: :space



  def votable_for?(space)
    !likes.exists?(space_id: space.id)
  end
end
