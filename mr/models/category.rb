module MR

  class Category < ActiveRecord::Base
    
    has_many :movies, :through => :movie_categories

  end

end