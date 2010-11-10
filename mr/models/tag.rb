module MR

  class Tag < ActiveRecord::Base
    has_many :movies, :through => :movie_tags

  end

end