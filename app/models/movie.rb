class Movie < ApplicationRecord
    has_many :bookmarks
    has_many :offers

    belongs_to :user through: :offers
end
