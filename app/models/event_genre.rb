class EventGenre < ApplicationRecord
  belongs_to :genre, dependent: :destroy
  belongs_to :event, dependent: :destroy
end
