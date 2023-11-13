class EventGenre < ApplicationRecord
  has_one :genre
  has_one :event
end
