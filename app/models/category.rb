class Category < ApplicationRecord
  has_many :space_category_relations
  has_many :spaces, through: :space_category_relations
end
