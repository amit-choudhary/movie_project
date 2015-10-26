class Location < ActiveRecord::Base

  validates :name, presence: true

  has_many :movies_locations, dependent: :destroy
  has_many :movies, through: :movies_locations

end
