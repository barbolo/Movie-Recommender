module MR

  class Movie < ActiveRecord::Base
    has_many :tags, :through => :movie_tags
    has_many :categories, :through => :movie_categories
    has_many :movie_ratings

  end

end