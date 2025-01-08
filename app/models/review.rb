class Review < ApplicationRecord
  belongs_to :space, optional: true
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 200 }
  validates :rating, presence: true,
  numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 6,
    allow_blank: true
  }
end
