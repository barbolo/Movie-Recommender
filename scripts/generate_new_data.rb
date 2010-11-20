require 'mr/mr'

=begin
query = %Q(
            SELECT movie_id, count(*) as total, AVG(rating) as avg_rating FROM mr.movie_ratings m
            GROUP BY movie_id HAVING total > 10 AND avg_rating > 3 ORDER BY avg_rating DESC
            LIMIT 0,1000
)

result = ActiveRecord::Base.connection.execute(query)

ids = []
File.open('data/filtered/chosen_movies.dat', 'w') do |f|
  result.each do |movie_id, total, avg_rating|
    ids.push movie_id
    f.write("#{movie_id}::#{avg_rating}\n")
    
  end
end

query = %Q(
            DELETE FROM mr.movie_ratings WHERE movie_id NOT IN (#{ids.join(',')})
)

ActiveRecord::Base.connection.execute(query)

=end
