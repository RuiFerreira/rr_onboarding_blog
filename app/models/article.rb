class Article < ApplicationRecord
  belongs_to :user
  enum status: {
    draft: 0,
    pending: 1,
    live: 2
  }

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :body, presence: true, length: { minimum: 20, maximum: 1000 }

  scope :user_live_articles, ->(user) { draft.where(user: user).or(Article.live) }
  scope :user_pending_articles, -> { pending } # TODO: add where user id not session user id here

  scope :articles_user_can_review, ->(user) { pending.where.not(user: user) }
end
