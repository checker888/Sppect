class Like < ApplicationRecord
  belongs_to :space, optional: true
  belongs_to :user, optional: true

  validate do
    unless user && user.votable_for?(space)
      errors.add(:base,:invalid)
    end
  end
end
