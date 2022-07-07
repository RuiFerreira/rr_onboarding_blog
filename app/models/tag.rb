class Tag < ApplicationRecord
  has_many :article_tags
  has_many :articles, through: :article_tags
  validates :name, presence: true,
                   uniqueness: [case_sensitive: false],
                   length: { minimum: 3, maximum: 20 }
end
