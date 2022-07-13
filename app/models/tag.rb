class Tag < ApplicationRecord
  has_many :associated_tags
  validates :name, presence: true,
                   uniqueness: [case_sensitive: false],
                   length: { minimum: 3, maximum: 20 }
                   
  scope :active_article_tags, -> { Tag.joins(:associated_tags,:tags).distinct }
end
