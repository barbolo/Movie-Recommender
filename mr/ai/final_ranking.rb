module MR
  module AI
  
    class FinalRanking
      
      def compute!
        query = %Q(
                    UPDATE
                      movies_similarities ms
                      SET final_ranking = 0.95*users_ranking + 0.05*categories_ranking
        )
        
        ActiveRecord::Base.connection.execute query
      end
      
    end
  
  end
end