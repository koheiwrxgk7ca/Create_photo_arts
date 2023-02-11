class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :photos, through: :tag_relations
end
