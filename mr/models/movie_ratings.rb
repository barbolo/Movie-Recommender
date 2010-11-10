module MR

  class MovieRating < ActiveRecord::Base
    belongs_to :movie

  end

end