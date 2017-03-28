class Post < ApplicationRecord
  belongs_to :user
  belongs_to :film

  scope :recent,   -> { order("created_at DESC")}
end
