class AssociatedTag < ApplicationRecord
  belongs_to :tagged_on, polymorphic: true, required: false
  belongs_to :tag
end
