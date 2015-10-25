class Movie < ActiveRecord::Base

  validates :title, presence: true

  has_many :movies_locations
  has_many :locations, through: :movies_locations
end
