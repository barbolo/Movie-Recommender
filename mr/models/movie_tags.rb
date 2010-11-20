class MovieTag < ActiveRecord::Base
  belongs_to :movie
  belongs_to :tag

end