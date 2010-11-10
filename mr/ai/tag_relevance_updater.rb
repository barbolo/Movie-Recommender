module MR
  module AI
  
    class TagRelevanceUpdater
      
      def update!
        query = %Q(
        
                  UPDATE
                    movie_tags mt
                      INNER JOIN tags t ON mt.tag_id = t.id
                      LEFT JOIN (
                                SELECT tag_id, COUNT(*) as counter FROM movie_tags GROUP BY tag_id
                                ) c ON t.id = c.tag_id
                    SET t.relevance = 1/counter
        
        )
        
        ActiveRecord::Base.connection.execute query
      end
      
    end
  
  end
end