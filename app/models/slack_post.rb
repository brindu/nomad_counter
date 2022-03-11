class SlackPost < ApplicationRecord
  has_one :event

  scope :discarded, -> { where(discarded: true) }
  scope :remaining, -> { where(discarded: false) }
end
