class User < ApplicationRecord
  has_many :bookmarks
  has_many :movies, dependent: :destroy
  has_many :offers, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :localisation
  after_validation :geocode
end
