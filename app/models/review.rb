class Review < ApplicationRecord
  belongs_to :space, optional: true
  belongs_to :user
end
