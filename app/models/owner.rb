class Owner < ApplicationRecord
  has_secure_password

  has_many :spaces, dependent: :destroy

  def votable_for?(space)
    !likes.exists?(space_id: space.id)
  end
end
