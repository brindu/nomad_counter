class SlackPost < ApplicationRecord
  has_one :event

  scope :discarded, -> { where(discarded: true) }
  scope :remaining, -> { includes(:event).where(discarded: false, events: { id: nil }) }
end
