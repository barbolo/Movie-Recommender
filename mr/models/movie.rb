class Movie < ActiveRecord::Base
  has_many :tags, :through => :movie_tags
  has_many :categories, :through => :movie_categories
  has_many :movie_ratings

  def similar_movies
    MoviesSimilarity.similar_movies(self)
  end

end