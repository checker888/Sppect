class Owner < ApplicationRecord
  has_secure_password

  has_many :spaces, dependent: :destroy

#validates address

  validates :name, presence: true,
  format: {
    with: /\A[A-Za-z][A-Za-z0-9]*\z/,
    allow_blank: true
  },
  length: { minimum: 2, maximum: 20, allow_blank: true },
  uniqueness: { case_sensitive: false }
  validates :phonenumber, presence: true,
  format: {
    with: /\A[0-9\(\)\-]*\z/,
  },
  length: { minimum: 10, maximum: 14, allow_blank: true },
  uniqueness: true
  validates :birthday, comparison: { less_than_or_equal_to: Date.today }
  validates :email, email: { allow_blank: true }
  attr_accessor :current_password
  validates :password, presence: {if: :current_password}
  
  def votable_for?(space)
    !likes.exists?(space_id: space.id)
  end
end
