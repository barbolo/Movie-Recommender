class MovieCategory < ActiveRecord::Base
  belongs_to :movie
  belongs_to :category

end