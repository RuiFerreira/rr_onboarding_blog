class Article < ApplicationRecord
  belongs_to :user
  
  has_many :article_tags
  has_many :tags, through: :article_tags

  enum status: {
    draft: 0,
    pending: 1,
    live: 2
  }

  self.locking_column = :edition_counter

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :body, presence: true, length: { minimum: 20, maximum: 1000 }

  scope :user_live_articles, ->(user) { draft.where(user: user).or(Article.live) }

  scope :articles_user_can_review, ->(user) { pending.where.not(user: user) }

  scope :filter_by_author_name, ->(author_name) {
    live.includes(:user).where('LOWER(users.username) LIKE ?', "%#{author_name.downcase}%").references(:user)
  }

  scope :filter_by_tags, ->(tag_names, article_list) {
    article_list.includes(article_tags: :tag).where(article_tags: { tags: { name: tag_names } })
  }

  scope :active_tags, -> {
    Tag.joins(:article_tags).group('article_tags.tag_id')
  }

end
