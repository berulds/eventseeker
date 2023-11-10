class Event < ApplicationRecord
  has_one :photo

  validates :name, :address, :start_time, :end_time, :description, presence: true
end
