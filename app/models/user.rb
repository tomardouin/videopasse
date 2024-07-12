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

  def self.haversine_distance(lat1, lon1, lat2, lon2)
    radius = 6371 # rayon de la Terre en kilomètres

    dlat = (lat2 - lat1) * Math::PI / 180
    dlon = (lon2 - lon1) * Math::PI / 180

    a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
        Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
        Math.sin(dlon / 2) * Math.sin(dlon / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    radius * c # distance en kilomètres
  end

  # Méthode pour calculer la distance à partir d'un autre utilisateur
  def distance_to(other_user)
    User.haversine_distance(self.latitude, self.longitude, other_user.latitude, other_user.longitude)
  end
end
