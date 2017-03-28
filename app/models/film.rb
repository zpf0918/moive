class Film < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :title, presence: true
end
