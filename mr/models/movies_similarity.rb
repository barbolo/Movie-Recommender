class MoviesSimilarity < ActiveRecord::Base
  #belongs_to :movie1, :class_name = 'MR::Movie', :foreign_key => 'movie_id_1'
  #belongs_to :movie2, :class_name = 'MR::Movie', :foreign_key => 'movie_id_2'

  def self.similar_movies(movie)
    MoviesSimilarity.similar_movies_from_id(movie.id)
  end
  
  def self.similar_movies_from_id(movie_id)
    query = %Q(
                SELECT movie_id_1, movie_id_2, users_ranking, categories_ranking, final_ranking
                FROM movies_similarities
                WHERE movie_id_1 = #{movie_id} OR movie_id_2 = #{movie_id}
                ORDER BY final_ranking DESC
                LIMIT 0,20
    )
    
    result = ActiveRecord::Base.connection.execute(query)
    
    mids = []
    result.each do |movie1, movie2, users, cats, final|
      if movie1.to_i == movie_id
        mids.push movie2.to_i
      else
        mids.push movie1.to_i
      end
    end
    
    return Movie.all(:conditions => ["id in (#{mids.join(',')})"]).sort{|a,b| mids.index(a.id) <=> mids.index(b.id)}
  end

end