class Tag < ApplicationRecord
  has_many :article_tags
  has_many :articles, through: :article_tags
  validates :name, presence: true,
                   uniqueness: [case_sensitive: false],
                   length: { minimum: 3, maximum: 20 }
                   
  scope :active_tags, -> {
    Tag.joins(:article_tags).group('article_tags.tag_id')
  }
end
