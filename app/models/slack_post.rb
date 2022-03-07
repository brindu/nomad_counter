class SlackPost < ApplicationRecord
  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }
end
