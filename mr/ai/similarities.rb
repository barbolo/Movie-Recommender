module MR
  module AI
    
    class Similarities
      
      def initialize
        @@total_categories = Category.count
      end
      
      def rank_movies
        
        movie_ids = Movie.find(:all, :select => 'id').collect {|r| r.id}
        
        movie1 = movie_ids.shift
        
        for moviex in movie_ids

          query = %Q(
                      SELECT mr1.rating, mr2.rating
                        FROM
                          movie_ratings mr1 LEFT JOIN movie_ratings mr2 ON mr1.user_id = mr2.user_id
                        WHERE
                          mr1.movie_id = #{movie1} AND mr2.movie_id = #{moviex}
                        LIMIT 0,50
          )
          
          result = ActiveRecord::Base.connection.execute(query)
          
          v1 = []
          v2 = []
          result.each do |rating1, rating2|
            v1.push rating1.to_i
            v2.push rating2.to_i
          end
          
          user_similarity = cosine(v1,v2)
          
          if user_similarity.class == Float
          
            MoviesSimilarity.create(
                                    :movie_id_1 => movie1,
                                    :movie_id_2 => moviex,
                                    :users_ranking => user_similarity
                                    )
          end
        end
        
      end
      
      def similarity_by_users(movie_id_1, movie_id_2)
        
      end
      
      def similarity_by_tags(movie_id_1, movie_id_2)
        
      end
      
      def similarity_by_categories(movie_id_1, movie_id_2)
        query = %Q(
        
            SELECT (#{@@total_categories} - count(result.total))/#{@@total_categories} as similarity FROM
              (
              SELECT count(*) as total
              FROM mr.movie_categories m
              WHERE m.movie_id IN (#{movie_id_1},#{movie_id_2})
              GROUP by category_id
              HAVING total = 1
              ) as result

          )
        
        similarity = ActiveRecord::Base.connection.execute(query).fetch_row[0]
      end
      
    end
    
  end
end