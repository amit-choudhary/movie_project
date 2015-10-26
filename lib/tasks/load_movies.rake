require 'csv'

desc "Load Movies data in movies table"
task load_movies: :environment do

  CSV.foreach(File.join(Rails.root.join('lib', 'data', 'Film_Locations_in_San_Francisco.csv')), { headers: true, :encoding => 'ISO-8859-1' } ) do |row|
    movie = Movie.find_by(title: row[0]) || Movie.new(title: row[0])
    movie.locations << Location.find_or_create_by(name: row[2])
    movie.save!
  end

end
