class Movie < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_and_year,
                against: [:title, :year],
                using: {
                  tsearch: { prefix: true }
                }
  has_many :bookmarks
  has_many :offers

  belongs_to :user




  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
