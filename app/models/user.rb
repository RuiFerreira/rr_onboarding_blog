class User < ApplicationRecord
  # "dependent: :destroy" ensures cascade deletion of all of the deleted user's articles
  has_many :articles, dependent: :destroy
  has_many :associated_tags, as: :tagged_on
  # define enum, default value is 0
  enum status: {
    enabled: 0,
    disabled: 1
  }

  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3, maximum: 25 }

  EMAIL_REGEX_VALIDATION = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze # freeze makes this object immutable
  validates :email, presence: true,
                    uniqueness: true,
                    length: { minimum: 3, maximum: 100 },
                    format: { with: EMAIL_REGEX_VALIDATION }

  has_secure_password

  scope :active_authors, -> {
    User.joins(:articles).group('articles.user_id, users.id')
  }
end
