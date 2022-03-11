class SlackPost < ApplicationRecord
  scope :discarded, -> { where(discarded: true) }
  scope :remaining, -> { where(discarded: false) }
end
