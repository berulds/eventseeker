class Bookmark < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :event
end
