class Itinerary < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :start_time, :end_time, presence: true
end
