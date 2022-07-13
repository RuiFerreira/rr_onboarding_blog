class Tag < ApplicationRecord
  belongs_to :tagged_on, polymorphic: true, required: false
  belongs_to :article, -> { where(tags: { tagged_on_type: 'Article' }) }, foreign_key: 'tagged_on_id', required: false
  belongs_to :user, -> { where(tags: { tagged_on_type: 'User' }) }, foreign_key: 'tagged_on_id', required: false


  validates :name, presence: true,
                   uniqueness: [case_sensitive: false],
                   length: { minimum: 3, maximum: 20 }
                   
  scope :active_tags, -> { Tag.joins(:article) }
end
