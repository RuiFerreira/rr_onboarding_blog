class Article < ApplicationRecord
  belongs_to :user
  
  has_many :article_tags
  has_many :tags, through: :article_tags

  enum status: {
    draft: 0,
    pending: 1,
    live: 2
  }

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :body, presence: true, length: { minimum: 20, maximum: 1000 }

  scope :user_live_articles, ->(user) { draft.where(user: user).or(Article.live) }

  scope :articles_user_can_review, ->(user) { pending.where.not(user: user) }

  scope :filter_by_author_name, ->(author_name) {
    user = User.where('LOWER(username) LIKE ?', "%#{author_name.downcase}%")
    live.where(user: user)
  }

  scope :filter_by_tags, ->(tag_names, article_list) {
    tags = Tag.where(name: tag_names)
    article_tags = ArticleTag.where(tag_id: tags).where(article_id: article_list)
    article_list.where(article_tags: article_tags)
  }

end
