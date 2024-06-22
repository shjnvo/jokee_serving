class Joke < ApplicationRecord
  scope :exclude_joke, -> (ids) { where.not(id: ids) }

  validates :content, presence: true
end
