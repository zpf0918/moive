class Film < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :title, presence: true

  has_many :films_relationships
  has_many :member, through: :film_relationship, source: :user
end
