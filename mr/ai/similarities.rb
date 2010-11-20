module MR
  module AI
    
    class Similarities
      
      def initialize
        @@total_tags = Tag.count
        @@total_categories = Category.count
      end
      
      def rank_movies
        movie_ids = Movie.find(:all, :select => 'id').collect {|r| r.id}
        total = movie_ids.size
        until (movie1 = movie_ids.shift).nil?
          puts "#{100*(total - movie_ids.size)/(total.to_f)}%"
          for moviex in movie_ids
          
            user_similarity = similarity_by_users(movie1, moviex)
            #tags_similarity = similarity_by_tags(movie1, moviex)
            tags_similarity = 0
            categories_similarity = similarity_by_categories(movie1, moviex)
          
            MoviesSimilarity.create(
                                    :movie_id_1 => movie1,
                                    :movie_id_2 => moviex,
                                    :users_ranking => user_similarity,
                                    :tags_ranking => tags_similarity,
                                    :categories_ranking => categories_similarity
                                    )
          end
        end
        
      end
      
      def similarity_by_users(movie1, movie2)
        query = %Q(
                    SELECT mr1.rating, mr2.rating
                      FROM
                        movie_ratings mr1 LEFT JOIN movie_ratings mr2 ON mr1.user_id = mr2.user_id
                      WHERE
                        mr1.movie_id = #{movie1} AND mr2.movie_id = #{movie2}
                      LIMIT 0,50
        )
        result = ActiveRecord::Base.connection.execute(query)
        
        v1 = []
        v2 = []
        result.each do |rating1, rating2|
          v1.push rating1.to_i
          v2.push rating2.to_i
        end
        
        if v1.size != v2.size or v1.size < 10
          user_similarity = 0
        else
          user_similarity = cosine(v1,v2)
        end
        
        return user_similarity
      end
      
      def similarity_by_tags(movie1, movie2)
        query = %Q(
            SELECT count(*) as similarity FROM
              (
              SELECT count(*) as total
              FROM mr.movie_tags m
              WHERE m.movie_id IN (#{movie1},#{movie2})
              GROUP by tag_id
              HAVING total = 2
              ) as result

          )
        
        similarity = ActiveRecord::Base.connection.execute(query).fetch_row[0].to_i
      end
      
      def similarity_by_categories(movie1, movie2)
=begin
        query = %Q(
            SELECT (#{@@total_categories} - count(result.total))/#{@@total_categories} as similarity FROM
              (
              SELECT count(*) as total
              FROM mr.movie_categories m
              WHERE m.movie_id IN (#{movie1},#{movie2})
              GROUP by category_id
              HAVING total = 1
              ) as result

          )
=end
        query = %Q(
            SELECT count(*) as similarity FROM
              (
              SELECT count(*) as total
              FROM mr.movie_categories m
              WHERE m.movie_id IN (#{movie1},#{movie2})
              GROUP by category_id
              HAVING total = 2
              ) as result

          )
        
        similarity = ActiveRecord::Base.connection.execute(query).fetch_row[0].to_i
      end
      
    end
    
  end
end