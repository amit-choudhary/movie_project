class MoviesLocation < ActiveRecord::Base
  belongs_to :location
  belongs_to :movie

  validates :movie, :location, presence: true

end
