module MR
  module AI
  
    class IntervalNormalizer
      
      def normalize!
        
        query = %Q(
                  DELETE FROM movies_similarities WHERE users_ranking = 0
        )
        
        min = 0
        max = 10
        
        # v2 = (v1 - p1_min)*(p2_max - p2_min)/(p1_max - p1_min)
        
        # categories min and max values
        category_min = MoviesSimilarity.minimum('categories_ranking')
        category_max = MoviesSimilarity.maximum('categories_ranking')
        category_factor = (max - min)/(category_max - category_min)
        
        # users min and max values
        user_min = MoviesSimilarity.minimum('users_ranking')
        user_max = MoviesSimilarity.maximum('users_ranking')
        user_factor = (max - min)/(user_max - user_min)
        
        # final min and max values
        final_min = MoviesSimilarity.minimum('final_ranking')
        final_max = MoviesSimilarity.maximum('final_ranking')
        final_factor = (max - min)/(final_max - final_min)
        
        query = %Q(
                  UPDATE
                    movies_similarities ms
                    SET
                      categories_ranking = (categories_ranking - #{category_min})*#{category_factor},
                      users_ranking = (users_ranking - #{user_min})*#{user_factor},
                      final_ranking = (final_ranking - #{final_min})*#{final_factor}
        )
        
        ActiveRecord::Base.connection.execute query
        
      end
      
    end
  
  end
end