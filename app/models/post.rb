class Post < ApplicationRecord
  scope :deleted, -> { enforced { where(deleted: true) } }
  scope :not_deleted, -> { enforced { where(deleted: false) } }
  scope :maybe_deleted, -> { enforced { where(deleted: [true, false]) } }
end
