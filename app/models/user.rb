class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :bookmarks, dependent: :destroy
  has_many :user_genres, dependent: :destroy
  has_many :itineraries, dependent: :destroy
  has_many :genres, through: :user_genres
  has_many :messages, dependent: :destroy

  validates :username, presence: true, uniqueness: true
end
