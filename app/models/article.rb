class Article < ApplicationRecord
  belongs_to :user
  enum status: {
    draft: 0,
    pending: 1,
    live: 2
  }

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :body, presence: true, length: { minimum: 20, maximum: 300 }
end
