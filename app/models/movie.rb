class Movie < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_and_year,
                against: [:title, :release_year],
                using: {
                  tsearch: { prefix: true }
                }
  has_many :bookmarks
  has_many :offers, dependent: :destroy

  belongs_to :user

  has_one_attached :photo

  validates :title, presence: true
  validates :overview, presence: true
  validates :genre_name, presence: true
end
